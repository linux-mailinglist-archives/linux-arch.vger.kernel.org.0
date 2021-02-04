Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2974430F823
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 17:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237266AbhBDQiH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Feb 2021 11:38:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:47458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238150AbhBDQeK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 4 Feb 2021 11:34:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 520B964DEC;
        Thu,  4 Feb 2021 16:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612456404;
        bh=ClwfZ4bh/g+nDNHgsihWdg81VOoI6Tov34mfQwcVTiQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FXJLCgVbcsBwD/eZ2udPLpIYTL9uP8O29EGdVxivSMxmjmE0GO9EcpugGPE/QJiEV
         zKIpmSXdsrxzwDZbAg85DQz4oAJx3r9PuJtDGPTSk/k2KuCwRlwZ0VRCfNUJ1rVUvB
         hySWqBMjpK+QxNB5KE203FEA/r7zsENWQUsFmfPrTf1FdgokpLN0+3TtXwfME3POLf
         wEssOD76gxpUHRU0MOnpr2G+zJe12xs4FGJ1aD17oGpLNF5brMaT5P6BHoIxtlI8LI
         gMdO4X41HVyQVaXgHIUuidkSfoJaqViMnCATdTDeB0WNxegWqjx4nIakKv7v6Jcr7E
         F/wVGxToP0j+A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F3F6840513; Thu,  4 Feb 2021 13:33:19 -0300 (-03)
Date:   Thu, 4 Feb 2021 13:33:19 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     bpf <bpf@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        dwarves@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jakub Jelinek <jakub@redhat.com>,
        Fangrui Song <maskray@google.com>,
        Caroline Tice <cmtice@google.com>,
        Nick Clifton <nickc@redhat.com>
Subject: [FIXED] Re: 5:11: in-kernel BTF is malformed
Message-ID: <20210204163319.GD910119@kernel.org>
References: <CAJCQCtSQLc0VHqO4BY_-YB2OmCNNmHCS6fNdQKmMWGn2v=Jpdw@mail.gmail.com>
 <CAJCQCtRHOidM7Vps1JQSpZA14u+B5fR860FwZB=eb1wYjTpqDw@mail.gmail.com>
 <CAEf4BzZ4oTB0-JizHe1VaCk2V+Jb9jJoTznkgh6CjE5VxNVqbg@mail.gmail.com>
 <CAJCQCtRw6UWGGvjn0x__godYKYQXXmtyQys4efW2Pb84Q5q8Eg@mail.gmail.com>
 <20210204010038.GA854763@kernel.org>
 <CAJCQCtQfgRp78_WSrSHLNUUYNCyOCH=vo10nVZW_cyMjpZiNJg@mail.gmail.com>
 <CAEf4Bza4XQxpS7VTNWGk6Rz-iUwZemF6+iAVBA_yvrWnV0k8Qg@mail.gmail.com>
 <CAJCQCtRDJ_uiJcanP_p+y6Kz76c4P-EmndMyfHN5f4rtkgYhjA@mail.gmail.com>
 <20210204132625.GB910119@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204132625.GB910119@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Em Thu, Feb 04, 2021 at 10:26:25AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Feb 03, 2021 at 07:10:52PM -0700, Chris Murphy escreveu:
> > On Wed, Feb 3, 2021 at 7:05 PM Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > > So it's a bitfield offset breakage that should be fixed in pahole 1.20.
 
> > Rawhide is currently still on
> > dwarves-1.19-2.fc34.x86_64
 
> > This might also be related:
> > https://bugzilla.redhat.com/show_bug.cgi?id=1922707#c9
 
> With about to be released pahole v1.20 it all seems to work, tldr;
 
> [root@seventh ~]# ~acme/git/pahole/btfdiff /lib/modules/`uname -r`/build/vmlinux
> [root@seventh ~]#
 
> Same thing. I'll do more tests after some errands, but I've put the pre-release
> rpm packages for 1.20 at:
 
> http://vger.kernel.org/~acme/pahole/rpms/1.20-0/RPMS/x86_64/Packages/
 
> Can you please try it with gcc 11?

Looking at the original source code in the kernel:

        /* Used for emulating ABI behavior of previous Linux versions: */
        unsigned int                    personality;

        /* Scheduler bits, serialized by scheduler locks: */
        unsigned                        sched_reset_on_fork:1;
        unsigned                        sched_contributes_to_load:1;
        unsigned                        sched_migrated:1;
#ifdef CONFIG_PSI
        unsigned                        sched_psi_wake_requeue:1;
#endif

        /* Force alignment to the next boundary: */
        unsigned                        :0;

        /* Unserialized, strictly 'current' */

        /*
         * This field must not be in the scheduler word above due to wakelist
         * queueing no longer being serialized by p->on_cpu. However:
         *
         * p->XXX = X;                  ttwu()
         * schedule()                     if (p->on_rq && ..) // false
         *   smp_mb__after_spinlock();    if (smp_load_acquire(&p->on_cpu) && //true
         *   deactivate_task()                ttwu_queue_wakelist())
         *     p->on_rq = 0;                    p->sched_remote_wakeup = Y;
         *
         * guarantees all stores of 'current' are visible before
         * ->sched_remote_wakeup gets used, so it can be in this word.
         */
        unsigned                        sched_remote_wakeup:1;

        /* Bit to tell LSMs we're in execve(): */
        unsigned                        in_execve:1;
        unsigned                        in_iowait:1;

Then the 'struct task_struct' as reconstructed by pahole from:
  
  $ ls -la /sys/kernel/btf/vmlinux
  -r--r--r--. 1 root root 4560322 Feb  4 10:16 /sys/kernel/btf/vmlinux
  $ ls -lah /sys/kernel/btf/vmlinux
  -r--r--r--. 1 root root 4.4M Feb  4 10:16 /sys/kernel/btf/vmlinux
  $

That was generated by 'pahole -J' from the default DWARF version
generated by gcc 11, we see that 'unsigned :0;' preserved (and that
isn't directly encoded in DWARF, so, to produce source code from it the
tool needs to add that "manually") and the byte offset (not
DW_AT_data_member_location isn't provided in such case) calculated from
the DW_AT_bit_offset (DWARF4/5 only stuff):

[acme@seventh perf]$ readelf -wi ../build/v5.11.0-rc6+/vmlinux | grep -m1 sched_reset_on_fork -A40 | grep -v DW_AT_decl_
    <1149>   DW_AT_name        : (indirect string, offset: 0x53da): sched_reset_on_fork
    <1151>   DW_AT_type        : <0x69>
    <1155>   DW_AT_bit_size    : 1
    <1155>   DW_AT_data_bit_offset: 18208
 <2><1157>: Abbrev Number: 29 (DW_TAG_member)
    <1158>   DW_AT_name        : (indirect string, offset: 0x3940): sched_contributes_to_load
    <1160>   DW_AT_type        : <0x69>
    <1164>   DW_AT_bit_size    : 1
    <1164>   DW_AT_data_bit_offset: 18209
 <2><1166>: Abbrev Number: 29 (DW_TAG_member)
    <1167>   DW_AT_name        : (indirect string, offset: 0x4883): sched_migrated
    <116f>   DW_AT_type        : <0x69>
    <1173>   DW_AT_bit_size    : 1
    <1173>   DW_AT_data_bit_offset: 18210
 <2><1175>: Abbrev Number: 29 (DW_TAG_member)
    <1176>   DW_AT_name        : (indirect string, offset: 0x3245): sched_psi_wake_requeue
    <117e>   DW_AT_type        : <0x69>
    <1182>   DW_AT_bit_size    : 1
    <1182>   DW_AT_data_bit_offset: 18211
 <2><1184>: Abbrev Number: 29 (DW_TAG_member)
    <1185>   DW_AT_name        : (indirect string, offset: 0xe4b): sched_remote_wakeup
    <118d>   DW_AT_type        : <0x69>
    <1191>   DW_AT_bit_size    : 1
    <1191>   DW_AT_data_bit_offset: 18240
 <2><1193>: Abbrev Number: 29 (DW_TAG_member)
    <1194>   DW_AT_name        : (indirect string, offset: 0x3ad4): in_execve
[acme@seventh perf]$ 

Looking at the options passed to gcc:

[acme@seventh perf]$ readelf -wi ../build/v5.11.0-rc6+/vmlinux | grep DW_AT_producer -m2
    <1c>   DW_AT_producer    : (indirect string, offset: 0x51): GNU AS 2.35.1
    <2f>   DW_AT_producer    : (indirect string, offset: 0x124a): GNU C89 11.0.0 20210123 (Red Hat 11.0.0-0) -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx -m64 -mno-80387 -mno-fp-ret-in-387 -mpreferred-stack-boundary=3 -mskip-rax-setup -mtune=generic -mno-red-zone -mcmodel=kernel -mindirect-branch=thunk-extern -mindirect-branch-register -mrecord-mcount -mfentry -march=x86-64 -g -O2 -std=gnu90 -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE -falign-jumps=1 -falign-loops=1 -fno-asynchronous-unwind-tables -fno-jump-tables -fno-delete-null-pointer-checks -fno-allow-store-data-races -fno-strict-overflow -fstack-check=no -fconserve-stack -fcf-protection=none -fno-stack-protector -fno-builtin
[acme@seventh perf]$

its just plain '-g'

Also using pahole's friend, fullcircle, we can see that it uses pfunct
to generate a compileable .c file from the DWARF thing, building it with
the same set of options used to build a .o file and then compares the
degugging info in the .c generated from the debugging info and checks
it matches, i.e. full circle.

[acme@seventh tmp]$ cp ~/git/build/v5.11.0-rc6+/net/ipv4/tcp.o .
[acme@seventh tmp]$ pahole -C task_struct tcp.o | tail

	/* --- cacheline 194 boundary (12416 bytes) --- */
	struct thread_struct       thread __attribute__((__aligned__(64))); /* 12416  4352 */

	/* size: 16768, cachelines: 262, members: 252 */
	/* sum members: 16579, holes: 22, sum holes: 173 */
	/* sum bitfield members: 77 bits, bit holes: 2, sum bit holes: 51 bits */
	/* paddings: 4, sum paddings: 21 */
	/* forced alignments: 8, forced holes: 2, sum forced holes: 96 */
} __attribute__((__aligned__(64)));
[acme@seventh tmp]$
[acme@seventh tmp]$ ~acme/git/pahole/fullcircle tcp.o
[acme@seventh tmp]$

For reference, here is the script:

  https://git.kernel.org/pub/scm/devel/pahole/pahole.git/tree/fullcircle

Then the next test is to build and use tools/bpf/runqslower/ that uses
CO-RE, i.e. it touches task_struct fields, etc, after building it:

[root@seventh linux]# tools/bpf/runqslower/.output/runqslower
Tracing run queue latency higher than 10000 us
TIME     COMM             PID           LAT(us)

And on the other terminal:

[root@seventh ~]# bpftool prog | grep handle__sched -A3
93: type 26  name handle__sched_w  tag 77e6e21acbdbb0f6  gpl
	loaded_at 2021-02-04T13:22:32-0300  uid 0
	xlated 152B  jited 93B  memlock 4096B  map_ids 23,21
	btf_id 194
95: type 26  name handle__sched_w  tag 77e6e21acbdbb0f6  gpl
	loaded_at 2021-02-04T13:22:32-0300  uid 0
	xlated 152B  jited 93B  memlock 4096B  map_ids 23,21
	btf_id 194
96: type 26  name handle__sched_s  tag 1c25b248d7358175  gpl
	loaded_at 2021-02-04T13:22:32-0300  uid 0
	xlated 560B  jited 332B  memlock 4096B  map_ids 23,21,22
	btf_id 194
[root@seventh ~]#

Ok, system is running smoothly, lets try with a lower threshold:

[root@seventh linux]# tools/bpf/runqslower/.output/runqslower 1000
Tracing run queue latency higher than 1000 us
TIME     COMM             PID           LAT(us)
13:24:31 swapper/3        5070             1405
13:24:31 swapper/2        2037             1369
13:24:31 swapper/3        5070             1263
13:24:32 swapper/0        645              1384
13:24:32 swapper/1        881              1384
13:24:32 abrt-dump-journ  5070             2064
13:24:32 systemd-journal  882              2135
13:24:32 abrt-dump-journ  645              2240
13:24:32 runqslower       2947             1317
13:24:32 iceccd           3839             1451
13:24:32 runqslower       241              1500
13:24:32 rcu_sched        5070             1794
13:24:32 swapper/2        176              1369
^C
[root@seventh linux]#

And furthermore:

[root@seventh linux]# file tools/bpf/runqslower/.output/runqslower.bpf.o
tools/bpf/runqslower/.output/runqslower.bpf.o: ELF 64-bit LSB relocatable, eBPF, version 1 (SYSV), not stripped
[root@seventh linux]# eu-readelf -winfo tools/bpf/runqslower/.output/runqslower.bpf.o
eu-readelf: cannot get debug context descriptor: No DWARF information found
[root@seventh linux]#
[root@seventh linux]# pahole -C task_struct tools/bpf/runqslower/.output/runqslower.bpf.o > BTF.generated-by-clang-for-a-BPF.target
[root@seventh linux]# pahole task_struct > BTF.generated-by-pahole-J-from-default-DWWARF-generated-by-gcc11-for-a-x86_64.target
[root@seventh linux]# diff -u BTF.generated-by-clang-for-a-BPF.target BTF.generated-by-pahole-J-from-default-DWWARF-generated-by-gcc11-for-a-x86_64.target
--- BTF.generated-by-clang-for-a-BPF.target	2021-02-04 13:26:16.215883852 -0300
+++ BTF.generated-by-pahole-J-from-default-DWWARF-generated-by-gcc11-for-a-x86_64.target	2021-02-04 13:27:07.483184784 -0300
@@ -49,8 +49,8 @@
 	/* --- cacheline 30 boundary (1920 bytes) was 56 bytes ago --- */
 	void *                     migration_pending;    /*  1976     8 */
 	/* --- cacheline 31 boundary (1984 bytes) --- */
-	unsigned short             migration_disabled;   /*  1984     2 */
-	unsigned short             migration_flags;      /*  1986     2 */
+	short unsigned int         migration_disabled;   /*  1984     2 */
+	short unsigned int         migration_flags;      /*  1986     2 */

 	/* XXX 4 bytes hole, try to pack */

@@ -284,8 +284,8 @@
 	struct list_head           perf_event_list;      /*  7016    16 */
 	struct mempolicy *         mempolicy;            /*  7032     8 */
 	/* --- cacheline 110 boundary (7040 bytes) --- */
-	short                      il_prev;              /*  7040     2 */
-	short                      pref_node_fork;       /*  7042     2 */
+	short int                  il_prev;              /*  7040     2 */
+	short int                  pref_node_fork;       /*  7042     2 */
 	int                        numa_scan_seq;        /*  7044     4 */
 	unsigned int               numa_scan_period;     /*  7048     4 */
 	unsigned int               numa_scan_period_max; /*  7052     4 */
[root@seventh linux]#

Not really a difference, but I'll check if I can remove this annoyance
in > 1.20 :-)

[root@seventh linux]# clang -v |& head -1
clang version 12.0.0 (https://github.com/llvm/llvm-project 87369c626114ae17f4c637635c119e6de0856a9a)
[root@seventh linux]#

So I think that for the problems related to building the kernel with gcc
11 in Fedora Rawhide using the default that is now DWARF5, pahole 1.20
is good to go and I'll tag it now.

- Arnaldo
