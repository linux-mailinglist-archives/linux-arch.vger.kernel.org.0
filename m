Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2BA20A720
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jun 2020 22:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405366AbgFYUzC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Jun 2020 16:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405184AbgFYUzB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Jun 2020 16:55:01 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21082C08C5C1
        for <linux-arch@vger.kernel.org>; Thu, 25 Jun 2020 13:55:01 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id l6so862635pjq.1
        for <linux-arch@vger.kernel.org>; Thu, 25 Jun 2020 13:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HCV92AuRvbw80BHFaZCrTSuoE9qKbEHrDwHHj8qVbjk=;
        b=EpzjcATfHOlWNN51fD+FPClL2ILnY2pWsOQiUtQwDXRODiQO0Dq/mLVCvOgtrJ42q9
         2zQ6QUkTaH77E2qPvQB+xzZsPHPinRv/TxQUSNTG6K2c7dh6u+XwedZ54suSXb/yiRgy
         8GUfMY3QvmTTBslHF06lGkqrndG4+LG07pjeN22MkzJzr4174+dntReA8MtaQbJyUG5y
         KvipZ1kqZcfU2pySr/OkzXbyVKIc3YhuU2txgZvjvz9LAX/KLYJ5TaF+lgWvGM0HMjz7
         zmvgESfRN67Jq1zG7m28dza2375HdzOcMPAPsZ8Epp3iNNTSlm+LXYKmCoJLRD7ezQc1
         Zzlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HCV92AuRvbw80BHFaZCrTSuoE9qKbEHrDwHHj8qVbjk=;
        b=Ict3YE7/UxhNRI7Tob3wGxiVGymWbhlDd+WlrjXVzL9AIkzuemCg6PphYSfOhqETlN
         /3hih/HlTLJr7WzlPe8U7pt+jdAZjOmogEHuP6rbEg/qiCtlonZ/nrh/EYkWHaA+xjfm
         YAkDZUrlUn9OR+xwAOet+MFCOzPHSMOfA1iFHJzn30kWQufT2ubxboxmUiq7uBWf0VM4
         ogcuZo5QSZxgfZPlu+M7nFMO6yJkj8sWJ4XZs2ZjXToYbj5E1c/xsoUKy57hk3zLMBG2
         lSM3dROpuyIAWny/76gvFtf/razZ9kLxVl6YNQJZSOLlhuY7Sj0xwaWe8jEYyljzW5jG
         t4bQ==
X-Gm-Message-State: AOAM5308ygSLfS3taY0IIxBLAm4X8e+UA7wWsL3nCVDfo+IzhE/Bn7yT
        idyBFmR/PSEOHixXEoEAO0pEfbtH/Sej0fZaGeDr+g==
X-Google-Smtp-Source: ABdhPJxZdFSmcPt6RuW6kGEUHo6tjLBTLQpNLW8FddduxVa7bC2Gh1K7Wa/SnHFGGRqAoDDIi/lPW+sLteXbXx8SWSU=
X-Received: by 2002:a17:902:ab8d:: with SMTP id f13mr23724588plr.119.1593118500279;
 Thu, 25 Jun 2020 13:55:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200624203200.78870-5-samitolvanen@google.com> <20200624212737.GV4817@hirez.programming.kicks-ass.net>
 <20200624214530.GA120457@google.com> <20200625074530.GW4817@hirez.programming.kicks-ass.net>
 <20200625161503.GB173089@google.com> <20200625200235.GQ4781@hirez.programming.kicks-ass.net>
In-Reply-To: <20200625200235.GQ4781@hirez.programming.kicks-ass.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 25 Jun 2020 13:54:48 -0700
Message-ID: <CAKwvOdmToWTaiaw0iX56FLeezW30k3S=pZLf97N2Ta7zJkSL0w@mail.gmail.com>
Subject: Re: [RFC][PATCH] objtool,x86_64: Replace recordmcount with objtool
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, mhelsley@vmware.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 25, 2020 at 1:02 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Jun 25, 2020 at 09:15:03AM -0700, Sami Tolvanen wrote:
> > On Thu, Jun 25, 2020 at 09:45:30AM +0200, Peter Zijlstra wrote:
>
> > > At least for x86_64 I can do a really quick take for a recordmcount pass
> > > in objtool, but I suppose you also need this for ARM64 ?
> >
> > Sure, sounds good. arm64 uses -fpatchable-function-entry with clang, so we
> > don't need recordmcount there.
>
> This is on top of my local pile:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git master
>
> which notably includes the static_call series.
>
> Not boot tested, but it generates the required sections and they look
> more or less as expected, ymmv.
>
> ---
>  arch/x86/Kconfig              |  1 -
>  scripts/Makefile.build        |  3 ++
>  scripts/link-vmlinux.sh       |  2 +-
>  tools/objtool/builtin-check.c |  9 ++---
>  tools/objtool/builtin.h       |  2 +-
>  tools/objtool/check.c         | 81 +++++++++++++++++++++++++++++++++++++++++++
>  tools/objtool/check.h         |  1 +
>  tools/objtool/objtool.h       |  1 +
>  8 files changed, 91 insertions(+), 9 deletions(-)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index a291823f3f26..189575c12434 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -174,7 +174,6 @@ config X86
>         select HAVE_EXIT_THREAD
>         select HAVE_FAST_GUP
>         select HAVE_FENTRY                      if X86_64 || DYNAMIC_FTRACE
> -       select HAVE_FTRACE_MCOUNT_RECORD
>         select HAVE_FUNCTION_GRAPH_TRACER
>         select HAVE_FUNCTION_TRACER
>         select HAVE_GCC_PLUGINS
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 2e8810b7e5ed..c774befc57da 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -227,6 +227,9 @@ endif
>  ifdef CONFIG_X86_SMAP
>    objtool_args += --uaccess
>  endif
> +ifdef CONFIG_DYNAMIC_FTRACE
> +  objtool_args += --mcount
> +endif
>
>  # 'OBJECT_FILES_NON_STANDARD := y': skip objtool checking for a directory
>  # 'OBJECT_FILES_NON_STANDARD_foo.o := 'y': skip objtool checking for a file
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index 92dd745906f4..00c6e4f28a1a 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -60,7 +60,7 @@ objtool_link()
>         local objtoolopt;
>
>         if [ -n "${CONFIG_VMLINUX_VALIDATION}" ]; then
> -               objtoolopt="check"
> +               objtoolopt="check --vmlinux"
>                 if [ -z "${CONFIG_FRAME_POINTER}" ]; then
>                         objtoolopt="${objtoolopt} --no-fp"
>                 fi
> diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
> index 4896c5a89702..a6c3a3fba67d 100644
> --- a/tools/objtool/builtin-check.c
> +++ b/tools/objtool/builtin-check.c
> @@ -18,7 +18,7 @@
>  #include "builtin.h"
>  #include "objtool.h"
>
> -bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats, validate_dup, vmlinux, fpu;
> +bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats, validate_dup, vmlinux, fpu, mcount;
>
>  static const char * const check_usage[] = {
>         "objtool check [<options>] file.o",
> @@ -36,12 +36,13 @@ const struct option check_options[] = {
>         OPT_BOOLEAN('d', "duplicate", &validate_dup, "duplicate validation for vmlinux.o"),
>         OPT_BOOLEAN('l', "vmlinux", &vmlinux, "vmlinux.o validation"),
>         OPT_BOOLEAN('F', "fpu", &fpu, "validate FPU context"),
> +       OPT_BOOLEAN('M', "mcount", &mcount, "generate __mcount_loc"),
>         OPT_END(),
>  };
>
>  int cmd_check(int argc, const char **argv)
>  {
> -       const char *objname, *s;
> +       const char *objname;
>
>         argc = parse_options(argc, argv, check_options, check_usage, 0);
>
> @@ -50,9 +51,5 @@ int cmd_check(int argc, const char **argv)
>
>         objname = argv[0];
>
> -       s = strstr(objname, "vmlinux.o");
> -       if (s && !s[9])
> -               vmlinux = true;
> -
>         return check(objname, false);
>  }
> diff --git a/tools/objtool/builtin.h b/tools/objtool/builtin.h
> index 7158e09d4cc9..b51d883ec245 100644
> --- a/tools/objtool/builtin.h
> +++ b/tools/objtool/builtin.h
> @@ -8,7 +8,7 @@
>  #include <subcmd/parse-options.h>
>
>  extern const struct option check_options[];
> -extern bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats, validate_dup, vmlinux, fpu;
> +extern bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats, validate_dup, vmlinux, fpu, mcount;
>
>  extern int cmd_check(int argc, const char **argv);
>  extern int cmd_orc(int argc, const char **argv);
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 6647a8d1545b..ee99566bdae9 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -533,6 +533,65 @@ static int create_static_call_sections(struct objtool_file *file)
>         return 0;
>  }
>
> +static int create_mcount_loc_sections(struct objtool_file *file)
> +{
> +       struct section *sec, *reloc_sec;
> +       struct reloc *reloc;
> +       unsigned long *loc;
> +       struct instruction *insn;
> +       int idx;
> +
> +       sec = find_section_by_name(file->elf, "__mcount_loc");
> +       if (sec) {
> +               INIT_LIST_HEAD(&file->mcount_loc_list);
> +               WARN("file already has __mcount_loc section, skipping");
> +               return 0;
> +       }
> +
> +       if (list_empty(&file->mcount_loc_list))
> +               return 0;
> +
> +       idx = 0;
> +       list_for_each_entry(insn, &file->mcount_loc_list, mcount_loc_node)
> +               idx++;
> +
> +       sec = elf_create_section(file->elf, "__mcount_loc", 0, sizeof(unsigned long), idx);
> +       if (!sec)
> +               return -1;
> +
> +       reloc_sec = elf_create_reloc_section(file->elf, sec, SHT_RELA);
> +       if (!reloc_sec)
> +               return -1;
> +
> +       idx = 0;
> +       list_for_each_entry(insn, &file->mcount_loc_list, mcount_loc_node) {
> +
> +               loc = (unsigned long *)sec->data->d_buf + idx;
> +               memset(loc, 0, sizeof(unsigned long));
> +
> +               reloc = malloc(sizeof(*reloc));
> +               if (!reloc) {
> +                       perror("malloc");
> +                       return -1;
> +               }
> +               memset(reloc, 0, sizeof(*reloc));

calloc(1, sizeof(*reloc))?

> +
> +               reloc->sym = insn->sec->sym;
> +               reloc->addend = insn->offset;
> +               reloc->type = R_X86_64_64;
> +               reloc->offset = idx * sizeof(unsigned long);
> +               reloc->sec = reloc_sec;
> +               elf_add_reloc(file->elf, reloc);
> +
> +               idx++;
> +       }
> +
> +       if (elf_rebuild_reloc_section(file->elf, reloc_sec))
> +               return -1;
> +
> +       return 0;
> +}
> +
>  /*
>   * Warnings shouldn't be reported for ignored functions.
>   */
> @@ -892,6 +951,22 @@ static int add_call_destinations(struct objtool_file *file)
>                         insn->type = INSN_NOP;
>                 }
>
> +               if (mcount && !strcmp(insn->call_dest->name, "__fentry__")) {
> +                       if (reloc) {
> +                               reloc->type = R_NONE;
> +                               elf_write_reloc(file->elf, reloc);
> +                       }
> +
> +                       elf_write_insn(file->elf, insn->sec,
> +                                      insn->offset, insn->len,
> +                                      arch_nop_insn(insn->len));
> +
> +                       insn->type = INSN_NOP;
> +
> +                       list_add_tail(&insn->mcount_loc_node,
> +                                     &file->mcount_loc_list);
> +               }
> +
>                 /*
>                  * Whatever stack impact regular CALLs have, should be undone
>                  * by the RETURN of the called function.
> @@ -3004,6 +3079,7 @@ int check(const char *_objname, bool orc)
>         INIT_LIST_HEAD(&file.insn_list);
>         hash_init(file.insn_hash);
>         INIT_LIST_HEAD(&file.static_call_list);
> +       INIT_LIST_HEAD(&file.mcount_loc_list);
>         file.c_file = !vmlinux && find_section_by_name(file.elf, ".comment");
>         file.ignore_unreachables = no_unreachable;
>         file.hints = false;
> @@ -3056,6 +3132,11 @@ int check(const char *_objname, bool orc)
>                 goto out;
>         warnings += ret;
>
> +       ret = create_mcount_loc_sections(&file);
> +       if (ret < 0)
> +               goto out;
> +       warnings += ret;
> +
>         if (orc) {
>                 ret = create_orc(&file);
>                 if (ret < 0)
> diff --git a/tools/objtool/check.h b/tools/objtool/check.h
> index cd95fca0d237..01f11b5da5dd 100644
> --- a/tools/objtool/check.h
> +++ b/tools/objtool/check.h
> @@ -24,6 +24,7 @@ struct instruction {
>         struct list_head list;
>         struct hlist_node hash;
>         struct list_head static_call_node;
> +       struct list_head mcount_loc_node;
>         struct section *sec;
>         unsigned long offset;
>         unsigned int len;
> diff --git a/tools/objtool/objtool.h b/tools/objtool/objtool.h
> index 9a7cd0b88bd8..f604b22d22cc 100644
> --- a/tools/objtool/objtool.h
> +++ b/tools/objtool/objtool.h
> @@ -17,6 +17,7 @@ struct objtool_file {
>         struct list_head insn_list;
>         DECLARE_HASHTABLE(insn_hash, 20);
>         struct list_head static_call_list;
> +       struct list_head mcount_loc_list;
>         bool ignore_unreachables, c_file, hints, rodata;
>  };
>


-- 
Thanks,
~Nick Desaulniers
