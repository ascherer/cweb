@s atomic int

@* Attributes. This is just all of the examples from the sections about
attributes in the \CEE/ and \CPLUSPLUS/ standards collected together, with most
comments removed.

@c
[[using CC: opt(1), debug]]
  void f() {}
[[using CC: opt(1)]] [[CC::debug]]
  void g() {}
[[using CC: CC::opt(1)]]
  void h() {}

int p[10];
void f() {
  int x = 42, y[5];
  int i [[vendor::attr([[]])]];
}

alignas(double) unsigned char c[sizeof(double)];
extern unsigned char c[sizeof(double)];

struct foo { int* a; int* b; };
std::atomic<struct foo *> foo_head[10];

int foo_array[10][10];

[[carries_dependency]] struct foo* f(int i) {
  return foo_head[i].load(memory_order::consume);
}

int g(int* x, int* y [[carries_dependency]]) {
  return kill_dependency(foo_array[*x][*y]);
}

[[carries_dependency]] struct foo* f(int i);
int g(int* x, int* y [[carries_dependency]]);

int c = 3;

void h(int i) {
  struct foo* p;

  p = f(i);
  do_something_with(g(&c, p->a));
  do_something_with(g(p->a, &c));
}

void f(int n) {
  void g(), h(), i();
  switch (n) {
  case 1:
  case 2:
    g();
    [[fallthrough]];
  case 3:
    do {
      [[fallthrough]];
    } while (false);
  case 6:
    do {
      [[fallthrough]];
    } while (n--);
  case 7:
    while (false) {
      [[fallthrough]];
    }
  case 5:
    h();
  case 4:
    i();
    [[fallthrough]];
  }
}

void g(int);
int f(int n) {
  if (n > 5) [[unlikely]] {
    g(0);
    return n * 2 + 1;
  }

  switch (n) {
  case 1:
    g(1);
    [[fallthrough]];

  [[likely]] case 2:
    g(2);
    break;
  }
  return 3;
}

[[maybe_unused]] void f([[maybe_unused]] bool thing1,
                        [[maybe_unused]] bool thing2) {
  [[maybe_unused]] bool b = thing1 && thing2;
  assert(b);
}

struct [[nodiscard]] my_scopeguard { int x; };
struct my_unique {
  my_unique() = default;
  [[nodiscard]] my_unique(int fd) { /* \dots */ }
  ~my_unique() noexcept { /* \dots */ }
  /* \dots */
};
struct [[nodiscard]] error_info { /* \dots */ };
error_info enable_missile_safety_mode();
void launch_missiles();
void test_missiles() {
  my_scopeguard();
  (void)my_scopeguard(),
    launch_missiles();
  my_unique(42);
  my_unique();
  enable_missile_safety_mode();
  launch_missiles();
}
error_info &foo();
void f() { foo(); }


[[ noreturn ]] void f() {
  throw "error";
}

[[ noreturn ]] void q(int i) {
  if (i > 0)
    throw "positive";
}

template<typename Key, typename Value,
         typename Hash, typename Pred, typename Allocator>
class hash_map {
  [[no_unique_address]] Hash hasher;
  [[no_unique_address]] Pred pred;
  [[no_unique_address]] Allocator alloc;
  Bucket *buckets;

public:

};

[[deprecated, hal::daisy]] double nine1000(double);
[[deprecated]] [[hal::daisy]] double nine1000(double);
[[deprecated]] double nine1000 [[hal::daisy]] (double);

[[__deprecated__, __hal__::__daisy__]] double nine1000(double);
[[__deprecated__]] [[__hal__::__daisy__]] double nine1000(double);
[[__deprecated__]] double nine1000 [[__hal__::__daisy__]] (double);
[[hal::daisy, hal::rosie]] double nine999(double);
[[hal::rosie, hal::daisy]] double nine999(double);

[[hal::daisy]] [[hal::rosie]] double nine999(double);
[[hal::rosie]] [[hal::daisy]] double nine999(double);

struct [[nodiscard]] error_info { /*\dots*/ };
struct error_info enable_missile_safety_mode(void);
void launch_missiles(void);
void test_missiles(void) {
enable_missile_safety_mode();
launch_missiles();
}

[[nodiscard]] int important_func(void);
void call(void) {
int i = important_func();
}

[[nodiscard("must check armed state")]]
bool arm_detonator(int);
void call(void) {
arm_detonator(3);
detonate();
}

[[maybe_unused]] void f([[maybe_unused]] int i) {
[[maybe_unused]] int j = i + 100;
assert(j);
}

struct [[deprecated]] S {
int a;
};
enum [[deprecated]] E1 {
one
};
enum E2 {
two [[deprecated("use ’three’ instead")]],
three
};
[[deprecated]] typedef int Foo;
void f1(struct S s) {
int i = one;
int j = two;
int k = three;
Foo f;
}
[[deprecated]] void f2(struct S s) {
int i = one;
int j = two;
int k = three;
Foo f;
}
struct [[deprecated]] T {
Foo f;
struct S s;
};

void f(int n) {
void g(void), h(void), i(void);
switch (n) {
case 1: /* diagnostic on fallthrough discouraged */
case 2:
g();
[[fallthrough]];
case 3: /* diagnostic on fallthrough discouraged */
h();
case 4: /* fallthrough diagnostic encouraged */
i();
[[fallthrough]]; /* constraint violation */
}
}

@* Numbers. Here are new numbers.

@c

int main(void)
{
  int decimal_integer = 100;
  int hex_integer = 0x42;
  int octal_integer = 0240;
  int binary_integer = 0b10101011;
  int separated_integer = 100'000'000;
  float binary_exponent = 0x1FFFFp10;
  float separated_float = 123.456'789'000e2;
  int normal_exponent = 123'456e789;
}

@* Lists amd Enumerations.

@c
int func(int,int,double); /* Rule 14 */

typedef enum {
  false, true /* Rule 4 */
} boolean;

typedef struct {
  int w, h; /* Rule 33 */
} area;

typedef int int_t, *intp_t, (&fp)(int,ulong), arr_t[10];
  /* Rule 118 (and Rule 117) */

int func(int a, int b, double c) /* Rule 14 */
{
   int t,u,v; /* Rule 33 */
   return a;
}

template<typename Key, typename Value,
         typename Hash, typename Pred, typename Allocator> /* Rule 153 */
class hash_map { };

@* Index.
