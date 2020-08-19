Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE5FC24A70E
	for <lists+linux-arch@lfdr.de>; Wed, 19 Aug 2020 21:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgHSToo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Aug 2020 15:44:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41642 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgHSTom (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Aug 2020 15:44:42 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597866280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AINU1esGzcrRIOW7eRcehsH4H2erF0S2S1Nr8oelaiM=;
        b=zgRpru0vafpXj5BMCd7J2XXIbj9JmCHA/x/xf8v1SLaFIcORODsOUP+Hah5ni1URQYvnmD
        H36wCkZSZsZumqjBN+RI5FpOR0yVbO79TkM4TcPI0XBuCCOTZzM6tSze1FI2BJhqq8XUBx
        pfW7Y1qxZZo4MwdWfuU5FHnLvhqv3aaNogcBRoRpEz5B7w6ofbGkHShG2HznNlSkakl3Uj
        T0TsS31u8SDSnp2WAaf1f8xiIHVKBCqzGo92izKj/za64AtUeKKiN5AX+bcHZgIJ6u0zGX
        AMQ6XwWOJBYIIb1813u5dEfv/yntcQcaKRDCLRCk1FJnDm+BXSumGgnMGvmyog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597866280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AINU1esGzcrRIOW7eRcehsH4H2erF0S2S1Nr8oelaiM=;
        b=DK2436jfqzsF8GCaoE1iVXsDyO84/rePl1qZE9MDMxjw4bG0NcbW6vsHPt/66S2tMAtN9p
        8uT28wC//hyxNeDA==
To:     Kyle Huey <me@kylehuey.com>, Kees Cook <keescook@chromium.org>
Cc:     Robert O'Callahan <rocallahan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "maintainer\:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [REGRESSION] x86/entry: Tracer no longer has opportunity to change the syscall number at entry via orig_ax
In-Reply-To: <CAP045Arc1Vdh+n2j2ELE3q7XfagLjyqXji9ZD0jqwVB-yuzq-g@mail.gmail.com>
References: <CAP045Arc1Vdh+n2j2ELE3q7XfagLjyqXji9ZD0jqwVB-yuzq-g@mail.gmail.com>
Date:   Wed, 19 Aug 2020 21:44:39 +0200
Message-ID: <87blj6ifo8.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 19 2020 at 10:14, Kyle Huey wrote:
> tl;dr: after 27d6b4d14f5c3ab21c4aef87dd04055a2d7adf14 ptracer
> modifications to orig_ax in a syscall entry trace stop are not honored
> and this breaks our code.

My fault and I have no idead why none of the silly test cases
noticed. Fix below.

Thanks,

        tglx
---
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 9852e0d62d95..fcae019158ca 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -65,7 +65,8 @@ static long syscall_trace_enter(struct pt_regs *regs, long syscall,
 
 	syscall_enter_audit(regs, syscall);
 
-	return ret ? : syscall;
+	/* The above might have changed the syscall number */
+	return ret ? : syscall_get_nr(current, regs);
 }
 
 noinstr long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)
