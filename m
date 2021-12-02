Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267F6466CBE
	for <lists+linux-arch@lfdr.de>; Thu,  2 Dec 2021 23:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240707AbhLBWgX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Dec 2021 17:36:23 -0500
Received: from mga03.intel.com ([134.134.136.65]:52279 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231240AbhLBWgW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 2 Dec 2021 17:36:22 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="236795767"
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="236795767"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 14:32:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="513400938"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga008.jf.intel.com with ESMTP; 02 Dec 2021 14:32:50 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 1B2MWmYR028552;
        Thu, 2 Dec 2021 22:32:48 GMT
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     linux-hardening@vger.kernel.org, x86@kernel.org
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Bruce Schlobohm <bruce.schlobohm@intel.com>,
        Jessica Yu <jeyu@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marios Pomonis <pomonis@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, live-patching@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH v8 00/14] Function Granular KASLR
Date:   Thu,  2 Dec 2021 23:32:00 +0100
Message-Id: <20211202223214.72888-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is a massive rework and a respin of Kristen Accardi's marvellous
FG-KASLR series (v5).

The major differences since v5 [0]:
* You can now tune the number of functions per each section to
  achieve the preferable vmlinux size or protection level. Default
  is still as one section per function.
  This can be handy for storage-constrained systems. 4-8 fps are
  still strong, but reduce the size of the final vmlinu{x,z}
  significantly (see the comparison below);
* I don't use orphan sections anymore. It's not reliable at all /
  may differ from linker to linker, and also conflicts with
  CONFIG_LD_ORPHAN_WARN which is great for catching random bugs ->
* All the .text.* sections are now being described explicitly in the
  linker script. A Perl script is used to take the original LDS, the
  original object file, read a list of input sections from it and
  generate the resulting LDS.
  This costs a bit of linking time as LD tends to think hard when
  processing scripts > 1 Mb (a subject for future BFD and LLD
  patches). It adds about 60-80 seconds to the whole linking process
  (BTF step, 2-3 kallsyms steps and the final step), but "better
  safe than sorry".
  In addition, that approach allows to reserve some space at the end
  of text (8-12 Kb, no impact on vmlinux size as THP-aligned (2 Mb)
  rodata goes right after it) and add some link-time assertions ->
* Input .text section now must be empty, otherwise the linkage will
  be stopped. This is implemented by the size assertion in the
  resulting LD script and is designed to plug the potentional layout
  leakage. This also means that ->
* "Regular" ASM functions are now being placed into unique separate
  functions the same way compiler does this for C functions. This is
  achieved by introducing and using several new macros which take
  the symbol name as a base for its new section name.
  This gives a better opportunity to LTO, DCE and FG-KASLR, as ASM
  code can now also be randomized or garbage-collected;
* It's now fully compatible with ClangLTO, ClangCFI,
  CONFIG_LD_ORPHAN_WARN and some all the rest stuff landed since the
  last revision has been published;
* Includes several fixes: relocations inside .altinstr_replacement
  code and minor style issues found and/or suggested by LKP robot.

The series has been compile-time and runtime tested on the following
setups with no issues:
- x86_64, GCC 11, Binutils 2.35;
- x86_64, Clang/LLVM 13, ClangLTO + ClangCFI (from Sami's tree).

Some numbers for comparison:
* make -j65 -- time of the full kernel compilation with the named
  option enabled (and -j$(($(nproc) + 1))), give to see mainly how
  linkers choke on big LD scripts;
* boot -- time elapsed from starting the kernel by the bootloader
  to login prompt, affected mostly by the main FG-KASLR preboot
  loop which shuffles function sections;
* vmlinux.o -- the size of the final vmlinux.o, altered by relocs
  and -ffunction-sections;
* vmlinux -- the size of the final vmlinux, depends directly on the
  number of (function) sections;
* bzImage -- the size of the final compressed kernel, same as with
  vmlinux;
* bogoops/s -- stress-ng -c$(nproc) results on the kernel with the
  named feature enabled;
* fps -- the number of functions per section, controlled by
  CONFIG_FG_KASLR_SHIFT and CONFIG_MODULE_FG_KASLR_SHIFT.
  16 fps means shift = 4, 8 fps on shift = 2, 1 fps for shift = 0.

feat        make -j65 boot    vmlinux.o vmlinux  bzImage  bogoops/s
Relocatable 4m38.478s 24.440s 72014208  58579520  9396192 57640.39
KASLR       4m39.344s 24.204s 72020624  87805776  9740352 57393.80
FG-K 16 fps 6m16.493s 25.429s 83759856  87194160 10885632 57784.76
FG-K 8 fps  6m20.190s 25.094s 83759856  88741328 10985248 56625.84
FG-K 1 fps  7m09.611s 25.922s 83759856  95681128 11352192 56953.99

From v7 (unreleased):
 - rebase on top of 5.16-rc3, notably:
 - drop 4 patches already taken in mainline;
 - adopt to the new exception handlers logics;
 - changed two new x86 ASM crypto module to generate function
   sections. Also:
 - improve generate_text_sections.pl script to address changes in
   Clang 13 emitting __cfi_check_fail() only on final linking;
 - retest on the latest stable Clang/LLVM stack (13);
 - add missing .lds rule to the top .gitignore.

From v6 [1]:
 - rebase on top of 5.15-rc1 and
   db2b0c5d7b6f ("objtool: Support pv_opsindirect calls for noinstr")
   from tip's objtool/core as there is plenty of counter-intuitive
   conflicts between these two;
 - change livepatch bit (#12) logics from forced overrride to exit
   with errno and a error message to make it more clear to the users
   (Miroslav);
 - expand the cover letter a bit, add some build-time and runtime
   numbers (Kees, Kristen).

The series is also available here: [2]

[0] https://lore.kernel.org/kernel-hardening/20200923173905.11219-1-kristen@linux.intel.com
[1] https://lore.kernel.org/kernel-hardening/20210831144114.154-1-alexandr.lobakin@intel.com
[2] https://github.com/alobakin/linux/pull/3

The original v5 cover letter:

Function Granular Kernel Address Space Layout Randomization (fgkaslr)
---------------------------------------------------------------------

This patch set is an implementation of finer grained kernel address space
randomization. It rearranges your kernel code at load time 
on a per-function level granularity, with only around a second added to
boot time.

Changes in v5:
--------------
* fixed a bug in the code which increases boot heap size for
  CONFIG_FG_KASLR which prevented the boot heap from being increased
  for CONFIG_FG_KASLR when using bzip2 compression. Thanks to Andy Lavr
  for finding the problem and identifying the solution.
* changed the adjustment of the orc_unwind_ip table at boot time to
  disregard relocs associated with this table, and instead inspect the
  entries separately. Relocs are not able to be used since they are
  no longer correct once the table is resorted at buildtime.
* changed how orc_unwind_ip addresses in randomized sections are identified
  to include the byte immediately after the end of the section.
* updated module code to use kvmalloc/kvfree based on suggestions from
  Evgenii Shatokhin <eshatokhin@virtuozzo.com>.
* changed kernel commandline to disable fgkaslr to simply "nofgkaslr" to
  match the nokaslr option. fgkaslr="X" can be added at a later date
  if it is needed.
* Added a patch to force livepatch to require symbols to be unique if
  using while fgkaslr either for core or modules.

Changes in v4:
-------------
* dropped the patch to split out change to STATIC definition in
  x86/boot/compressed/misc.c and replaced with a patch authored
  by Kees Cook to avoid the duplicate malloc definitions
* Added a section to Documentation/admin-guide/kernel-parameters.txt
  to document the fgkaslr boot option.
* redesigned the patch to hide the new layout when reading
  /proc/kallsyms. The previous implementation utilized a dynamically
  allocated linked list to display the kernel and module symbols
  in alphabetical order. The new implementation uses a randomly
  shuffled index array to display the kernel and module symbols
  in a random order.

Changes in v3:
-------------
* Makefile changes to accommodate CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
* removal of extraneous ALIGN_PAGE from _etext changes
* changed variable names in x86/tools/relocs to be less confusing
* split out change to STATIC definition in x86/boot/compressed/misc.c
* Updates to Documentation to make it more clear what is preserved in .text
* much more detailed commit message for function granular KASLR patch
* minor tweaks and changes that make for more readable code
* this cover letter updated slightly to add additional details

Changes in v2:
--------------
* Fix to address i386 build failure
* Allow module reordering patch to be configured separately so that
  arm (or other non-x86_64 arches) can take advantage of module function
  reordering. This support has not be tested by me, but smoke tested by
  Ard Biesheuvel <ardb@kernel.org> on arm.
* Fix build issue when building on arm as reported by
  Ard Biesheuvel <ardb@kernel.org> 

Patches to objtool are included because they are dependencies for this
patchset, however they have been submitted by their maintainer separately.

Background
----------
KASLR was merged into the kernel with the objective of increasing the
difficulty of code reuse attacks. Code reuse attacks reused existing code
snippets to get around existing memory protections. They exploit software bugs
which expose addresses of useful code snippets to control the flow of
execution for their own nefarious purposes. KASLR moves the entire kernel
code text as a unit at boot time in order to make addresses less predictable.
The order of the code within the segment is unchanged - only the base address
is shifted. There are a few shortcomings to this algorithm.

1. Low Entropy - there are only so many locations the kernel can fit in. This
   means an attacker could guess without too much trouble.
2. Knowledge of a single address can reveal the offset of the base address,
   exposing all other locations for a published/known kernel image.
3. Info leaks abound.

Finer grained ASLR has been proposed as a way to make ASLR more resistant
to info leaks. It is not a new concept at all, and there are many variations
possible. Function reordering is an implementation of finer grained ASLR
which randomizes the layout of an address space on a function level
granularity. We use the term "fgkaslr" in this document to refer to the
technique of function reordering when used with KASLR, as well as finer grained
KASLR in general.

Proposed Improvement
--------------------
This patch set proposes adding function reordering on top of the existing
KASLR base address randomization. The over-arching objective is incremental
improvement over what we already have. It is designed to work in combination
with the existing solution. The implementation is really pretty simple, and
there are 2 main area where changes occur:

* Build time

GCC has had an option to place functions into individual .text sections for
many years now. This option can be used to implement function reordering at
load time. The final compiled vmlinux retains all the section headers, which
can be used to help find the address ranges of each function. Using this
information and an expanded table of relocation addresses, individual text
sections can be suffled immediately after decompression. Some data tables
inside the kernel that have assumptions about order require re-sorting
after being updated when applying relocations. In order to modify these tables,
a few key symbols are excluded from the objcopy symbol stripping process for
use after shuffling the text segments.

Some highlights from the build time changes to look for:

The top level kernel Makefile was modified to add the gcc flag if it
is supported. Currently, I am applying this flag to everything it is
possible to randomize. Anything that is written in C and not present in a
special input section is randomized. The final binary segment 0 retains a
consolidated .text section, as well as all the individual .text.* sections.
Future work could turn off this flags for selected files or even entire
subsystems, although obviously at the cost of security.

The relocs tool is updated to add relative relocations. This information
previously wasn't included because it wasn't necessary when moving the
entire .text segment as a unit. 

A new file was created to contain a list of symbols that objcopy should
keep. We use those symbols at load time as described below.

* Load time

The boot kernel was modified to parse the vmlinux elf file after
decompression to check for our interesting symbols that we kept, and to
look for any .text.* sections to randomize. The consolidated .text section
is skipped and not moved. The sections are shuffled randomly, and copied
into memory following the .text section in a new random order. The existing
code which updated relocation addresses was modified to account for
not just a fixed delta from the load address, but the offset that the function
section was moved to. This requires inspection of each address to see if
it was impacted by a randomization. We use a bsearch to make this less
horrible on performance. Any tables that need to be modified with new
addresses or resorted are updated using the symbol addresses parsed from the
elf symbol table.

In order to hide our new layout, symbols reported through /proc/kallsyms
will be displayed in a random order.

Security Considerations
-----------------------
The objective of this patch set is to improve a technology that is already
merged into the kernel (KASLR). This code will not prevent all attacks,
but should instead be considered as one of several tools that can be used.
In particular, this code is meant to make KASLR more effective in the presence
of info leaks.

How much entropy we are adding to the existing entropy of standard KASLR will
depend on a few variables. Firstly and most obviously, the number of functions
that are randomized matters. This implementation keeps the existing .text
section for code that cannot be randomized - for example, because it was
assembly code. The less sections to randomize, the less entropy. In addition,
due to alignment (16 bytes for x86_64), the number of bits in a address that
the attacker needs to guess is reduced, as the lower bits are identical.

Performance Impact
------------------
There are two areas where function reordering can impact performance: boot
time latency, and run time performance.

* Boot time latency
This implementation of finer grained KASLR impacts the boot time of the kernel
in several places. It requires additional parsing of the kernel ELF file to
obtain the section headers of the sections to be randomized. It calls the
random number generator for each section to be randomized to determine that
section's new memory location. It copies the decompressed kernel into a new
area of memory to avoid corruption when laying out the newly randomized
sections. It increases the number of relocations the kernel has to perform at
boot time vs. standard KASLR, and it also requires a lookup on each address
that needs to be relocated to see if it was in a randomized section and needs
to be adjusted by a new offset. Finally, it re-sorts a few data tables that
are required to be sorted by address.

Booting a test VM on a modern, well appointed system showed an increase in
latency of approximately 1 second.

* Run time
The performance impact at run-time of function reordering varies by workload.
Using kcbench, a kernel compilation benchmark, the performance of a kernel
build with finer grained KASLR was about 1% slower than a kernel with standard
KASLR. Analysis with perf showed a slightly higher percentage of 
L1-icache-load-misses. Other workloads were examined as well, with varied
results. Some workloads performed significantly worse under FGKASLR, while
others stayed the same or were mysteriously better. In general, it will
depend on the code flow whether or not finer grained KASLR will impact
your workload, and how the underlying code was designed. Because the layout
changes per boot, each time a system is rebooted the performance of a workload
may change.

Future work could identify hot areas that may not be randomized and either
leave them in the .text section or group them together into a single section
that may be randomized. If grouping things together helps, one other thing to
consider is that if we could identify text blobs that should be grouped together
to benefit a particular code flow, it could be interesting to explore
whether this security feature could be also be used as a performance
feature if you are interested in optimizing your kernel layout for a
particular workload at boot time. Optimizing function layout for a particular
workload has been researched and proven effective - for more information
read the Facebook paper "Optimizing Function Placement for Large-Scale
Data-Center Applications" (see references section below).

Image Size
----------
Adding additional section headers as a result of compiling with
-ffunction-sections will increase the size of the vmlinux ELF file.
With a standard distro config, the resulting vmlinux was increased by
about 3%. The compressed image is also increased due to the header files,
as well as the extra relocations that must be added. You can expect fgkaslr
to increase the size of the compressed image by about 15%.

Memory Usage
------------
fgkaslr increases the amount of heap that is required at boot time,
although this extra memory is released when the kernel has finished
decompression. As a result, it may not be appropriate to use this feature on
systems without much memory.

Building
--------
To enable fine grained KASLR, you need to have the following config options
set (including all the ones you would use to build normal KASLR)

CONFIG_FG_KASLR=y

In addition, fgkaslr is only supported for the X86_64 architecture.

Modules
-------
Modules are randomized similarly to the rest of the kernel by shuffling
the sections at load time prior to moving them into memory. The module must
also have been build with the -ffunction-sections compiler option.

Although fgkaslr for the kernel is only supported for the X86_64 architecture,
it is possible to use fgkaslr with modules on other architectures. To enable
this feature, select

CONFIG_MODULE_FG_KASLR=y

This option is selected automatically for X86_64 when CONFIG_FG_KASLR is set.

Disabling
---------
Disabling normal KASLR using the nokaslr command line option also disables
fgkaslr. It is also possible to disable fgkaslr separately by booting with
nofgkaslr on the commandline.

References
----------
There are a lot of academic papers which explore finer grained ASLR.
This paper in particular contributed the most to my implementation design
as well as my overall understanding of the problem space:

Selfrando: Securing the Tor Browser against De-anonymization Exploits,
M. Conti, S. Crane, T. Frassetto, et al.

For more information on how function layout impacts performance, see:

Optimizing Function Placement for Large-Scale Data-Center Applications,
G. Ottoni, B. Maher

Alexander Lobakin (8):
  linkage: add macros for putting ASM functions into own sections
  x86: conditionally place regular ASM functions into separate sections
  FG-KASLR: use a scripted approach to handle .text.* sections
  livepatch: only match unique symbols when using FG-KASLR
  x86/boot: allow FG-KASLR to be selected
  arm64/crypto: conditionally place ASM functions into separate sections
  module: use a scripted approach for FG-KASLR
  maintainers: add MAINTAINERS entry for FG-KASLR

Kristen Carlson Accardi (6):
  x86: Makefile: Add build and config option for CONFIG_FG_KASLR
  x86/tools: Add relative relocs for randomized functions
  x86: Add support for function granular KASLR
  kallsyms: Hide layout
  module: Reorder functions
  Documentation: add documentation for FG-KASLR

 .gitignore                                    |   1 +
 .../admin-guide/kernel-parameters.txt         |   6 +
 Documentation/security/fgkaslr.rst            | 172 ++++
 Documentation/security/index.rst              |   1 +
 MAINTAINERS                                   |  12 +
 Makefile                                      |  17 +-
 arch/Kconfig                                  |   3 +
 arch/arm64/crypto/aes-ce-ccm-core.S           |  16 +-
 arch/arm64/crypto/aes-ce-core.S               |  16 +-
 arch/arm64/crypto/aes-ce.S                    |   4 +-
 arch/arm64/crypto/aes-cipher-core.S           |   8 +-
 arch/arm64/crypto/aes-modes.S                 |  16 +-
 arch/arm64/crypto/aes-neon.S                  |   4 +-
 arch/arm64/crypto/aes-neonbs-core.S           |  38 +-
 arch/arm64/crypto/chacha-neon-core.S          |  18 +-
 arch/arm64/crypto/crct10dif-ce-core.S         |  14 +-
 arch/arm64/crypto/ghash-ce-core.S             |  24 +-
 arch/arm64/crypto/nh-neon-core.S              |   4 +-
 arch/arm64/crypto/poly1305-armv8.pl           |  17 +
 arch/arm64/crypto/sha1-ce-core.S              |   4 +-
 arch/arm64/crypto/sha2-ce-core.S              |   4 +-
 arch/arm64/crypto/sha3-ce-core.S              |   4 +-
 arch/arm64/crypto/sha512-armv8.pl             |  11 +
 arch/arm64/crypto/sha512-ce-core.S            |   4 +-
 arch/arm64/crypto/sm3-ce-core.S               |   4 +-
 arch/arm64/crypto/sm4-ce-core.S               |   4 +-
 arch/x86/Kconfig                              |   1 +
 arch/x86/boot/compressed/Makefile             |   9 +-
 arch/x86/boot/compressed/fgkaslr.c            | 893 ++++++++++++++++++
 arch/x86/boot/compressed/misc.c               | 154 ++-
 arch/x86/boot/compressed/misc.h               |  28 +
 arch/x86/boot/compressed/utils.c              |  13 +
 arch/x86/boot/compressed/vmlinux.symbols      |  19 +
 arch/x86/crypto/aegis128-aesni-asm.S          |  36 +-
 arch/x86/crypto/aes_ctrby8_avx-x86_64.S       |  12 +-
 arch/x86/crypto/aesni-intel_asm.S             | 116 ++-
 arch/x86/crypto/aesni-intel_avx-x86_64.S      |  32 +-
 arch/x86/crypto/blake2s-core.S                |   8 +-
 arch/x86/crypto/blowfish-x86_64-asm_64.S      |  16 +-
 arch/x86/crypto/camellia-aesni-avx-asm_64.S   |  28 +-
 arch/x86/crypto/camellia-aesni-avx2-asm_64.S  |  28 +-
 arch/x86/crypto/camellia-x86_64-asm_64.S      |  16 +-
 arch/x86/crypto/cast5-avx-x86_64-asm_64.S     |  24 +-
 arch/x86/crypto/cast6-avx-x86_64-asm_64.S     |  20 +-
 arch/x86/crypto/chacha-avx2-x86_64.S          |  12 +-
 arch/x86/crypto/chacha-avx512vl-x86_64.S      |  12 +-
 arch/x86/crypto/chacha-ssse3-x86_64.S         |  16 +-
 arch/x86/crypto/crc32-pclmul_asm.S            |   4 +-
 arch/x86/crypto/crc32c-pcl-intel-asm_64.S     |   4 +-
 arch/x86/crypto/crct10dif-pcl-asm_64.S        |   4 +-
 arch/x86/crypto/des3_ede-asm_64.S             |   8 +-
 arch/x86/crypto/ghash-clmulni-intel_asm.S     |  12 +-
 arch/x86/crypto/nh-avx2-x86_64.S              |   4 +-
 arch/x86/crypto/nh-sse2-x86_64.S              |   4 +-
 arch/x86/crypto/poly1305-x86_64-cryptogams.pl |   8 +-
 arch/x86/crypto/serpent-avx-x86_64-asm_64.S   |  20 +-
 arch/x86/crypto/serpent-avx2-asm_64.S         |  20 +-
 arch/x86/crypto/serpent-sse2-i586-asm_32.S    |   8 +-
 arch/x86/crypto/serpent-sse2-x86_64-asm_64.S  |   8 +-
 arch/x86/crypto/sha1_avx2_x86_64_asm.S        |   4 +-
 arch/x86/crypto/sha1_ni_asm.S                 |   4 +-
 arch/x86/crypto/sha1_ssse3_asm.S              |   4 +-
 arch/x86/crypto/sha256-avx-asm.S              |   4 +-
 arch/x86/crypto/sha256-avx2-asm.S             |   4 +-
 arch/x86/crypto/sha256-ssse3-asm.S            |   4 +-
 arch/x86/crypto/sha256_ni_asm.S               |   4 +-
 arch/x86/crypto/sha512-avx-asm.S              |   4 +-
 arch/x86/crypto/sha512-avx2-asm.S             |   4 +-
 arch/x86/crypto/sha512-ssse3-asm.S            |   4 +-
 arch/x86/crypto/sm4-aesni-avx-asm_64.S        |  24 +-
 arch/x86/crypto/sm4-aesni-avx2-asm_64.S       |  16 +-
 arch/x86/crypto/twofish-avx-x86_64-asm_64.S   |  20 +-
 arch/x86/crypto/twofish-i586-asm_32.S         |   8 +-
 arch/x86/crypto/twofish-x86_64-asm_64-3way.S  |   8 +-
 arch/x86/crypto/twofish-x86_64-asm_64.S       |   8 +-
 arch/x86/entry/entry_32.S                     |  24 +-
 arch/x86/entry/entry_64.S                     |  18 +-
 arch/x86/entry/thunk_32.S                     |   4 +-
 arch/x86/entry/thunk_64.S                     |   8 +-
 arch/x86/include/asm/boot.h                   |  13 +-
 arch/x86/include/asm/paravirt.h               |   5 +-
 arch/x86/include/asm/qspinlock_paravirt.h     |   2 +-
 arch/x86/kernel/acpi/wakeup_32.S              |   9 +-
 arch/x86/kernel/acpi/wakeup_64.S              |  10 +-
 arch/x86/kernel/ftrace_32.S                   |  19 +-
 arch/x86/kernel/ftrace_64.S                   |  24 +-
 arch/x86/kernel/kprobes/core.c                |   3 +-
 arch/x86/kernel/kvm.c                         |   2 +-
 arch/x86/kernel/relocate_kernel_32.S          |   2 +
 arch/x86/kernel/relocate_kernel_64.S          |   2 +
 arch/x86/kernel/vmlinux.lds.S                 |   6 +-
 arch/x86/kvm/emulate.c                        |   2 +-
 arch/x86/kvm/vmx/vmenter.S                    |   8 +-
 arch/x86/lib/clear_page_64.S                  |  12 +-
 arch/x86/lib/cmpxchg16b_emu.S                 |   4 +-
 arch/x86/lib/copy_mc_64.S                     |   8 +-
 arch/x86/lib/copy_page_64.S                   |   7 +-
 arch/x86/lib/copy_user_64.S                   |  18 +-
 arch/x86/lib/csum-copy_64.S                   |   4 +-
 arch/x86/lib/error-inject.c                   |   3 +-
 arch/x86/lib/getuser.S                        |  37 +-
 arch/x86/lib/hweight.S                        |   9 +-
 arch/x86/lib/iomap_copy_64.S                  |   4 +-
 arch/x86/lib/memmove_64.S                     |   4 +-
 arch/x86/lib/memset_64.S                      |  12 +-
 arch/x86/lib/msr-reg.S                        |   8 +-
 arch/x86/lib/putuser.S                        |  18 +-
 arch/x86/mm/mem_encrypt_boot.S                |   8 +-
 arch/x86/platform/efi/efi_stub_64.S           |   4 +-
 arch/x86/platform/efi/efi_thunk_64.S          |   4 +-
 arch/x86/power/hibernate_asm_32.S             |  14 +-
 arch/x86/power/hibernate_asm_64.S             |  14 +-
 arch/x86/tools/relocs.c                       |  32 +-
 arch/x86/tools/relocs.h                       |   4 +-
 arch/x86/tools/relocs_common.c                |  14 +-
 arch/x86/xen/xen-asm.S                        |  24 +-
 arch/x86/xen/xen-head.S                       |   6 +-
 include/asm-generic/vmlinux.lds.h             |  38 +-
 include/linux/linkage.h                       |  82 ++
 include/uapi/linux/elf.h                      |   1 +
 init/Kconfig                                  |  51 +
 kernel/kallsyms.c                             | 158 +++-
 kernel/livepatch/core.c                       |  13 +
 kernel/module.c                               |  91 +-
 scripts/Makefile.modfinal                     |  19 +-
 scripts/generate_text_sections.pl             | 163 ++++
 scripts/link-vmlinux.sh                       |  25 +-
 scripts/module.lds.S                          |  14 +-
 128 files changed, 2609 insertions(+), 626 deletions(-)
 create mode 100644 Documentation/security/fgkaslr.rst
 create mode 100644 arch/x86/boot/compressed/fgkaslr.c
 create mode 100644 arch/x86/boot/compressed/utils.c
 create mode 100644 arch/x86/boot/compressed/vmlinux.symbols
 create mode 100755 scripts/generate_text_sections.pl

-- 
2.33.1

