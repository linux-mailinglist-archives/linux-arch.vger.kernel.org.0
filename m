Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48755349944
	for <lists+linux-arch@lfdr.de>; Thu, 25 Mar 2021 19:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbhCYSOK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Mar 2021 14:14:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:55656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229664AbhCYSNh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 Mar 2021 14:13:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 00F0061A2B
        for <linux-arch@vger.kernel.org>; Thu, 25 Mar 2021 18:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616696017;
        bh=hZbr/YAUwDJRi/e7rsYBbBBiGANyECd5A/VOAhqz7wk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hJkyC37npz3ddXbIxwl22nrSkR1wgVdAr30SQdWH16OikLxFGYPUIZKB7Kgm1+IdJ
         Wl6wmXT50eIzxF/ImTZ/27DFiiuZvLbC6rEvRss8A6jOeono+DOZAtmCiHkqGDXvLW
         a1zW1Gpf3jhLcl2h50cg3oM5lqc+8dmy585KdNRV47qvN+vZFCQ/QZKBLMCjGpdwoE
         nE3RBL12VeWueZnSnqrLTcXXGyw53gYPReh8cpDwH682fpZZecTis4CD+s8VG11Fxj
         9Cj365Q7yy1+NI4l6kZtzHjJzwkVvPwEtpwDsL3nWsLMMsvukjQbmXR4gjcmtVSqWx
         imoMtzohC4JNg==
Received: by mail-ej1-f44.google.com with SMTP id w3so4477862ejc.4
        for <linux-arch@vger.kernel.org>; Thu, 25 Mar 2021 11:13:36 -0700 (PDT)
X-Gm-Message-State: AOAM532Zu2G3ocDuyx+ZuRZ1tmmR6GnIr6W3199INiUMmLlW9NVsTF3q
        jMHGlk+0stoJxFgKy2enpfj31xNfJfzW9t5Sa6iV7Q==
X-Google-Smtp-Source: ABdhPJyx+eCOdwHkNoC4wXQ2v057iyu0Pe04Uri0ZrEq6Y2j1ldA+VoHipL2EZfdXYWLwCD4h12QT/xvPxqxP5wxNEI=
X-Received: by 2002:a17:907:e88:: with SMTP id ho8mr11290121ejc.199.1616696004901;
 Thu, 25 Mar 2021 11:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210316065215.23768-1-chang.seok.bae@intel.com> <20210316065215.23768-6-chang.seok.bae@intel.com>
In-Reply-To: <20210316065215.23768-6-chang.seok.bae@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 25 Mar 2021 11:13:12 -0700
X-Gmail-Original-Message-ID: <CALCETrU_n+dP4GaUJRQoKcDSwaWL9Vc99Yy+N=QGVZ_tx_j3Zg@mail.gmail.com>
Message-ID: <CALCETrU_n+dP4GaUJRQoKcDSwaWL9Vc99Yy+N=QGVZ_tx_j3Zg@mail.gmail.com>
Subject: Re: [PATCH v7 5/6] x86/signal: Detect and prevent an alternate signal
 stack overflow
To:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Cc:     Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "H. J. Lu" <hjl.tools@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Jann Horn <jannh@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Carlos O'Donell" <carlos@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000001546ed05be605f58"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--0000000000001546ed05be605f58
Content-Type: text/plain; charset="UTF-8"

On Mon, Mar 15, 2021 at 11:57 PM Chang S. Bae <chang.seok.bae@intel.com> wrote:
>
> The kernel pushes context on to the userspace stack to prepare for the
> user's signal handler. When the user has supplied an alternate signal
> stack, via sigaltstack(2), it is easy for the kernel to verify that the
> stack size is sufficient for the current hardware context.
>
> Check if writing the hardware context to the alternate stack will exceed
> it's size. If yes, then instead of corrupting user-data and proceeding with
> the original signal handler, an immediate SIGSEGV signal is delivered.
>
> Instead of calling on_sig_stack(), directly check the new stack pointer
> whether in the bounds.
>
> While the kernel allows new source code to discover and use a sufficient
> alternate signal stack size, this check is still necessary to protect
> binaries with insufficient alternate signal stack size from data
> corruption.

This patch results in excessively complicated control and data flow.

> -       int onsigstack = on_sig_stack(sp);
> +       bool onsigstack = on_sig_stack(sp);

Here onsigstack means "we were already using the altstack".

>         int ret;
>
>         /* redzone */
> @@ -251,8 +251,11 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
>
>         /* This is the X/Open sanctioned signal stack switching.  */
>         if (ka->sa.sa_flags & SA_ONSTACK) {
> -               if (sas_ss_flags(sp) == 0)
> +               if (sas_ss_flags(sp) == 0) {
>                         sp = current->sas_ss_sp + current->sas_ss_size;
> +                       /* On the alternate signal stack */
> +                       onsigstack = true;
> +               }

But now onsigstack is also true if we are using the legacy path to
*enter* the altstack.  So now it's (was on altstack) || (entering
altstack via legacy path).

>         } else if (IS_ENABLED(CONFIG_X86_32) &&
>                    !onsigstack &&
>                    regs->ss != __USER_DS &&
> @@ -272,7 +275,8 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
>          * If we are on the alternate signal stack and would overflow it, don't.
>          * Return an always-bogus address instead so we will die with SIGSEGV.
>          */
> -       if (onsigstack && !likely(on_sig_stack(sp)))
> +       if (onsigstack && unlikely(sp <= current->sas_ss_sp ||
> +                                  sp - current->sas_ss_sp > current->sas_ss_size))

And now we fail if ((was on altstack) || (entering altstack via legacy
path)) && (new sp is out of bounds).


The condition we actually want is that, if we are entering the
altstack and we don't fit, we should fail.  This is tricky because of
the autodisarm stuff and the possibility of nonlinear stack segments,
so it's not even clear to me exactly what we should be doing.  I
propose:




>                 return (void __user *)-1L;

Can we please log something (if (show_unhandled_signals ||
printk_ratelimit()) that says that we overflowed the altstack?

How about:

diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index ea794a083c44..53781324a2d3 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -237,7 +237,8 @@ get_sigframe(struct k_sigaction *ka, struct
pt_regs *regs, size_t frame_size,
     unsigned long math_size = 0;
     unsigned long sp = regs->sp;
     unsigned long buf_fx = 0;
-    int onsigstack = on_sig_stack(sp);
+    bool already_onsigstack = on_sig_stack(sp);
+    bool entering_altstack = false;
     int ret;

     /* redzone */
@@ -246,15 +247,25 @@ get_sigframe(struct k_sigaction *ka, struct
pt_regs *regs, size_t frame_size,

     /* This is the X/Open sanctioned signal stack switching.  */
     if (ka->sa.sa_flags & SA_ONSTACK) {
-        if (sas_ss_flags(sp) == 0)
+        /*
+         * This checks already_onsigstack via sas_ss_flags().
+         * Sensible programs use SS_AUTODISARM, which disables
+         * that check, and programs that don't use
+         * SS_AUTODISARM get compatible but potentially
+         * bizarre behavior.
+         */
+        if (sas_ss_flags(sp) == 0) {
             sp = current->sas_ss_sp + current->sas_ss_size;
+            entering_altstack = true;
+        }
     } else if (IS_ENABLED(CONFIG_X86_32) &&
-           !onsigstack &&
+           !already_onsigstack &&
            regs->ss != __USER_DS &&
            !(ka->sa.sa_flags & SA_RESTORER) &&
            ka->sa.sa_restorer) {
         /* This is the legacy signal stack switching. */
         sp = (unsigned long) ka->sa.sa_restorer;
+        entering_altstack = true;
     }

     sp = fpu__alloc_mathframe(sp, IS_ENABLED(CONFIG_X86_32),
@@ -267,8 +278,16 @@ get_sigframe(struct k_sigaction *ka, struct
pt_regs *regs, size_t frame_size,
      * If we are on the alternate signal stack and would overflow it, don't.
      * Return an always-bogus address instead so we will die with SIGSEGV.
      */
-    if (onsigstack && !likely(on_sig_stack(sp)))
+    if (unlikely(entering_altstack &&
+             (sp <= current->sas_ss_sp ||
+              sp - current->sas_ss_sp > current->sas_ss_size))) {
+        if (show_unhandled_signals && printk_ratelimit()) {
+            pr_info("%s[%d] overflowed sigaltstack",
+                tsk->comm, task_pid_nr(tsk));
+        }
+
         return (void __user *)-1L;
+    }

     /* save i387 and extended state */
     ret = copy_fpstate_to_sigframe(*fpstate, (void __user *)buf_fx, math_size);

Apologies for whitespace damage.  I attached it, too.

--0000000000001546ed05be605f58
Content-Type: text/x-patch; charset="US-ASCII"; name="stack.patch"
Content-Disposition: attachment; filename="stack.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kmp71t930>
X-Attachment-Id: f_kmp71t930

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9zaWduYWwuYyBiL2FyY2gveDg2L2tlcm5lbC9z
aWduYWwuYwppbmRleCBlYTc5NGEwODNjNDQuLjUzNzgxMzI0YTJkMyAxMDA2NDQKLS0tIGEvYXJj
aC94ODYva2VybmVsL3NpZ25hbC5jCisrKyBiL2FyY2gveDg2L2tlcm5lbC9zaWduYWwuYwpAQCAt
MjM3LDcgKzIzNyw4IEBAIGdldF9zaWdmcmFtZShzdHJ1Y3Qga19zaWdhY3Rpb24gKmthLCBzdHJ1
Y3QgcHRfcmVncyAqcmVncywgc2l6ZV90IGZyYW1lX3NpemUsCiAJdW5zaWduZWQgbG9uZyBtYXRo
X3NpemUgPSAwOwogCXVuc2lnbmVkIGxvbmcgc3AgPSByZWdzLT5zcDsKIAl1bnNpZ25lZCBsb25n
IGJ1Zl9meCA9IDA7Ci0JaW50IG9uc2lnc3RhY2sgPSBvbl9zaWdfc3RhY2soc3ApOworCWJvb2wg
YWxyZWFkeV9vbnNpZ3N0YWNrID0gb25fc2lnX3N0YWNrKHNwKTsKKwlib29sIGVudGVyaW5nX2Fs
dHN0YWNrID0gZmFsc2U7CiAJaW50IHJldDsKIAogCS8qIHJlZHpvbmUgKi8KQEAgLTI0NiwxNSAr
MjQ3LDI1IEBAIGdldF9zaWdmcmFtZShzdHJ1Y3Qga19zaWdhY3Rpb24gKmthLCBzdHJ1Y3QgcHRf
cmVncyAqcmVncywgc2l6ZV90IGZyYW1lX3NpemUsCiAKIAkvKiBUaGlzIGlzIHRoZSBYL09wZW4g
c2FuY3Rpb25lZCBzaWduYWwgc3RhY2sgc3dpdGNoaW5nLiAgKi8KIAlpZiAoa2EtPnNhLnNhX2Zs
YWdzICYgU0FfT05TVEFDSykgewotCQlpZiAoc2FzX3NzX2ZsYWdzKHNwKSA9PSAwKQorCQkvKgor
CQkgKiBUaGlzIGNoZWNrcyBhbHJlYWR5X29uc2lnc3RhY2sgdmlhIHNhc19zc19mbGFncygpLgor
CQkgKiBTZW5zaWJsZSBwcm9ncmFtcyB1c2UgU1NfQVVUT0RJU0FSTSwgd2hpY2ggZGlzYWJsZXMK
KwkJICogdGhhdCBjaGVjaywgYW5kIHByb2dyYW1zIHRoYXQgZG9uJ3QgdXNlCisJCSAqIFNTX0FV
VE9ESVNBUk0gZ2V0IGNvbXBhdGlibGUgYnV0IHBvdGVudGlhbGx5CisJCSAqIGJpemFycmUgYmVo
YXZpb3IuCisJCSAqLworCQlpZiAoc2FzX3NzX2ZsYWdzKHNwKSA9PSAwKSB7CiAJCQlzcCA9IGN1
cnJlbnQtPnNhc19zc19zcCArIGN1cnJlbnQtPnNhc19zc19zaXplOworCQkJZW50ZXJpbmdfYWx0
c3RhY2sgPSB0cnVlOworCQl9CiAJfSBlbHNlIGlmIChJU19FTkFCTEVEKENPTkZJR19YODZfMzIp
ICYmCi0JCSAgICFvbnNpZ3N0YWNrICYmCisJCSAgICFhbHJlYWR5X29uc2lnc3RhY2sgJiYKIAkJ
ICAgcmVncy0+c3MgIT0gX19VU0VSX0RTICYmCiAJCSAgICEoa2EtPnNhLnNhX2ZsYWdzICYgU0Ff
UkVTVE9SRVIpICYmCiAJCSAgIGthLT5zYS5zYV9yZXN0b3JlcikgewogCQkvKiBUaGlzIGlzIHRo
ZSBsZWdhY3kgc2lnbmFsIHN0YWNrIHN3aXRjaGluZy4gKi8KIAkJc3AgPSAodW5zaWduZWQgbG9u
Zykga2EtPnNhLnNhX3Jlc3RvcmVyOworCQllbnRlcmluZ19hbHRzdGFjayA9IHRydWU7CiAJfQog
CiAJc3AgPSBmcHVfX2FsbG9jX21hdGhmcmFtZShzcCwgSVNfRU5BQkxFRChDT05GSUdfWDg2XzMy
KSwKQEAgLTI2Nyw4ICsyNzgsMTYgQEAgZ2V0X3NpZ2ZyYW1lKHN0cnVjdCBrX3NpZ2FjdGlvbiAq
a2EsIHN0cnVjdCBwdF9yZWdzICpyZWdzLCBzaXplX3QgZnJhbWVfc2l6ZSwKIAkgKiBJZiB3ZSBh
cmUgb24gdGhlIGFsdGVybmF0ZSBzaWduYWwgc3RhY2sgYW5kIHdvdWxkIG92ZXJmbG93IGl0LCBk
b24ndC4KIAkgKiBSZXR1cm4gYW4gYWx3YXlzLWJvZ3VzIGFkZHJlc3MgaW5zdGVhZCBzbyB3ZSB3
aWxsIGRpZSB3aXRoIFNJR1NFR1YuCiAJICovCi0JaWYgKG9uc2lnc3RhY2sgJiYgIWxpa2VseShv
bl9zaWdfc3RhY2soc3ApKSkKKwlpZiAodW5saWtlbHkoZW50ZXJpbmdfYWx0c3RhY2sgJiYKKwkJ
ICAgICAoc3AgPD0gY3VycmVudC0+c2FzX3NzX3NwIHx8CisJCSAgICAgIHNwIC0gY3VycmVudC0+
c2FzX3NzX3NwID4gY3VycmVudC0+c2FzX3NzX3NpemUpKSkgeworCQlpZiAoc2hvd191bmhhbmRs
ZWRfc2lnbmFscyAmJiBwcmludGtfcmF0ZWxpbWl0KCkpIHsKKwkJCXByX2luZm8oIiVzWyVkXSBv
dmVyZmxvd2VkIHNpZ2FsdHN0YWNrIiwKKwkJCQl0c2stPmNvbW0sIHRhc2tfcGlkX25yKHRzaykp
OworCQl9CisKIAkJcmV0dXJuICh2b2lkIF9fdXNlciAqKS0xTDsKKwl9CiAKIAkvKiBzYXZlIGkz
ODcgYW5kIGV4dGVuZGVkIHN0YXRlICovCiAJcmV0ID0gY29weV9mcHN0YXRlX3RvX3NpZ2ZyYW1l
KCpmcHN0YXRlLCAodm9pZCBfX3VzZXIgKilidWZfZngsIG1hdGhfc2l6ZSk7Cg==
--0000000000001546ed05be605f58--
