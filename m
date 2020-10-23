Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 890FF2975D5
	for <lists+linux-arch@lfdr.de>; Fri, 23 Oct 2020 19:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751579AbgJWRgZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Oct 2020 13:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753571AbgJWRgZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Oct 2020 13:36:25 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62474C0613D2
        for <linux-arch@vger.kernel.org>; Fri, 23 Oct 2020 10:36:25 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id j18so1908490pfa.0
        for <linux-arch@vger.kernel.org>; Fri, 23 Oct 2020 10:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v3oHNxup2Z/X3RcAQV9SdzT2AuZvE2TJPMlTRy4UVdg=;
        b=Z3Q8f+9RLq4ubmLePTMZVaggismFpKyU9D+I+6AiCOk4KvSVUOSNNZHXKxoPBh7GWY
         RClqHZm+Nfyudz9TEQyjxZMXOurxVJZX4mhjPfYxWkNyr/cAAEGYBbDAp5v2k6CMHKfq
         MxenOHLvWzjF6pubORCn8kVCK413lsXyOSsLbJ1trk61ipxsduiT0ok47wFrcNPbCcVG
         iiwP2bcnvlcv3dbrI1o9h1196320FtFTcf/aywJkmezF05US8O7ooXg0u/bJ/hMpDIr5
         +3GbzQLq4yHFL0EImfjvXUY3X7MZpkijg/UDpo6v1eWZb+7VchisG+G2qcBvKiNl6iKu
         Zb3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v3oHNxup2Z/X3RcAQV9SdzT2AuZvE2TJPMlTRy4UVdg=;
        b=FSMNbSON6cHvF6lRM6MebQ03+8R6xQsxBZ+BiC8iBuqMYXg9yYoGn93dIXHWMzxZh2
         BxWL5t1vUwpFhLgaKFFTiS3LxdLgBpsFc82j87pTN0mdNbaiqJuSpvqh49/jleRCEP9J
         WT4cMi4603fyhbH6lM0CK3fJZvmQN9zq31RySyNxl1fup2nxHVytOXrC5zZ+W000o2JQ
         Ub+9T4feouFDI0BJvTtFxivr7YMVedQW+3U4r+bGNdh0305pgg0kSbTExPoK5LzOTfSm
         R06HRuNUBNqO7nQHafPAmUySbp2H7NFkv10IZ6IlFXUUXpOLc17QQ0BCO9DVC2ljWUy2
         F9aQ==
X-Gm-Message-State: AOAM531wYkOS/9ViWBCaKv+opu/RXBz4d/j/YdO8EnV7B2/szOYXL9Fq
        UkB+xVmBns7FbId6lORshAVjew==
X-Google-Smtp-Source: ABdhPJy9hwXaRUl3z4AovIgAs9ZJu1Si99KmTZKm04vtb887MHqVl15EEMpST1nCdQo3PBn3pgvq6Q==
X-Received: by 2002:a63:370f:: with SMTP id e15mr3039898pga.124.1603474584438;
        Fri, 23 Oct 2020 10:36:24 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
        by smtp.gmail.com with ESMTPSA id m3sm2611808pfk.23.2020.10.23.10.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 10:36:23 -0700 (PDT)
Date:   Fri, 23 Oct 2020 10:36:17 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jannh@google.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 22/25] x86/asm: annotate indirect jumps
Message-ID: <20201023173617.GA3021099@google.com>
References: <20201013003203.4168817-1-samitolvanen@google.com>
 <20201013003203.4168817-23-samitolvanen@google.com>
 <CAG48ez2baAvKDA0wfYLKy-KnM_1CdOwjU873VJGDM=CErjsv_A@mail.gmail.com>
 <20201015102216.GB2611@hirez.programming.kicks-ass.net>
 <20201015203942.f3kwcohcwwa6lagd@treble>
 <CABCJKufDLmBCwmgGnfLcBw_B_4U8VY-R-dSNNp86TFfuMobPMw@mail.gmail.com>
 <20201020185217.ilg6w5l7ujau2246@treble>
 <CABCJKucVjFtrOsw58kn4OnW5kdkUh8G7Zs4s6QU9s6O7soRiAA@mail.gmail.com>
 <20201021085606.GZ2628@hirez.programming.kicks-ass.net>
 <CABCJKufL6=FiaeD8T0P+mK4JeR9J80hhjvJ6Z9S-m9UnCESxVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABCJKufL6=FiaeD8T0P+mK4JeR9J80hhjvJ6Z9S-m9UnCESxVA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 21, 2020 at 05:22:59PM -0700, Sami Tolvanen wrote:
> There are a couple of differences, like the first "undefined stack
> state" warning pointing to set_bringup_idt_handler.constprop.0()
> instead of __switch_to_asm(). I tried running this with --backtrace,
> but objtool segfaults at the first .entry.text warning:

Looks like it segfaults when calling BT_FUNC() for an instruction that
doesn't have a section (?). Applying this patch allows objtool to finish
with --backtrace:

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index c216dd4d662c..618b0c4f2890 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2604,7 +2604,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 				ret = validate_branch(file, func,
 						      insn->jump_dest, state);
 				if (ret) {
-					if (backtrace)
+					if (backtrace && insn->sec)
 						BT_FUNC("(branch)", insn);
 					return ret;
 				}


Running objtool -barfld on an allyesconfig+LTO vmlinux.o prints out the
following, ignoring the crypto warnings for now:

__switch_to_asm()+0x0: undefined stack state
  xen_hypercall_set_trap_table()+0x0: <=== (sym)
.entry.text+0xffd: sibling call from callable instruction with modified stack frame
  .entry.text+0xfcb: (branch)
  .entry.text+0xfb5: (alt)
  .entry.text+0xfb0: (alt)
  .entry.text+0xf78: (branch)
  .entry.text+0x9c: (branch)
  xen_syscall_target()+0x15: (branch)
  xen_syscall_target()+0x0: <=== (sym)
.entry.text+0x1754: unsupported instruction in callable function
  .entry.text+0x171d: (branch)
  .entry.text+0x1707: (alt)
  .entry.text+0x1701: (alt)
  xen_syscall32_target()+0x15: (branch)
  xen_syscall32_target()+0x0: <=== (sym)
.entry.text+0x1634: redundant CLD
do_suspend_lowlevel()+0x116: sibling call from callable instruction with modified stack frame
  do_suspend_lowlevel()+0x9a: (branch)
  do_suspend_lowlevel()+0x0: <=== (sym)
... [skipping crypto stack pointer alignment warnings] ...
__x86_retpoline_rdi()+0x10: return with modified stack frame
  __x86_retpoline_rdi()+0x0: (branch)
  .altinstr_replacement+0x13d: (branch)
  .text+0xaf4c7: (alt)
  .text+0xb03b0: (branch)
  .text+0xaf482: (branch)
  crc_pcl()+0x10: (branch)
  crc_pcl()+0x0: <=== (sym)
__x86_retpoline_rdi()+0x0: stack state mismatch: cfa1=7+32 cfa2=7+8
  .altinstr_replacement+0x20b: (branch)
  __x86_indirect_thunk_rdi()+0x0: (alt)
  __x86_indirect_thunk_rdi()+0x0: <=== (sym)
.head.text+0xfb: unsupported instruction in callable function
  .head.text+0x207: (branch)
  sev_es_play_dead()+0xff: (branch)
  sev_es_play_dead()+0xd2: (branch)
  sev_es_play_dead()+0xa8: (alt)
  sev_es_play_dead()+0x144: (branch)
  sev_es_play_dead()+0x10b: (branch)
  sev_es_play_dead()+0x1f: (branch)
  sev_es_play_dead()+0x0: <=== (sym)
__x86_retpoline_rdi()+0x0: stack state mismatch: cfa1=7+32 cfa2=-1+0
  .altinstr_replacement+0x107: (branch)
  .text+0x2885: (alt)
  .text+0x2860: <=== (hint)
.entry.text+0x48: stack state mismatch: cfa1=7-8 cfa2=-1+0
  .altinstr_replacement+0xffffffffffffffff: (branch)
  .entry.text+0x21: (alt)
  .entry.text+0x1c: (alt)
  .entry.text+0x10: <=== (hint)
.entry.text+0x15fd: stack state mismatch: cfa1=7-8 cfa2=-1+0
  .altinstr_replacement+0xffffffffffffffff: (branch)
  .entry.text+0x15dc: (alt)
  .entry.text+0x15d7: (alt)
  .entry.text+0x15d0: <=== (hint)
.entry.text+0x168c: stack state mismatch: cfa1=7-8 cfa2=-1+0
  .altinstr_replacement+0xffffffffffffffff: (branch)
  .entry.text+0x166b: (alt)
  .entry.text+0x1666: (alt)
  .entry.text+0x1660: <=== (hint)

Sami
