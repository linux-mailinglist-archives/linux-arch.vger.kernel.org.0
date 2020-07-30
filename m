Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C955232C6C
	for <lists+linux-arch@lfdr.de>; Thu, 30 Jul 2020 09:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbgG3HTE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Jul 2020 03:19:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48322 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgG3HTE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Jul 2020 03:19:04 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596093541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pJGza9Pz+sV1Z8JGFBKIAwU8e2IyPGK36s3Pj76aQFE=;
        b=i9avbnTss81DkmBzU4BwIQNN/Yy7tEFYX/dK7y+O1TjsfZ9E2+cfxC3b4j5IJpTxKmHAII
        whwYXMHShIF6fD/tQooG3Vltg+wAQHByKlZ3DlASU+RpbMeyOBVATbZ4bHwVlE1JeeCt6c
        SXlKqLrRlN4vfvjJ+9X1qTb/8MaaoTi3pAlIQf0CgcfJC3R/OG+g3NW1/iK7NbLRnLC0ca
        HA7rlYqcLRrVqpTYvl6GgVUwylc6FB8fC+UvKbYIS0jnJw5iDdxRV2BFNOJlll08B713yD
        eyJnNuYJtCYCHCn1qkljUGL+ztB00SE440sPS7Ts72ds8AsGGsOlD1xnCyVj0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596093541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pJGza9Pz+sV1Z8JGFBKIAwU8e2IyPGK36s3Pj76aQFE=;
        b=v2/7CCNT5pPmG7kimp3idDxfwKe1F9dXaGk7jvbAsZThXuDU2Utaa7pkHv4D1liE56BZXu
        giFq8KLWyl5AnrAw==
To:     Qian Cai <cai@lca.pw>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        sfr@canb.auug.org.au, linux-next@vger.kernel.org
Subject: Re: [patch V5 05/15] entry: Provide infrastructure for work before transitioning to guest mode
In-Reply-To: <20200729165524.GA4178@lca.pw>
References: <20200722215954.464281930@linutronix.de> <20200722220519.833296398@linutronix.de> <20200729165524.GA4178@lca.pw>
Date:   Thu, 30 Jul 2020 09:19:01 +0200
Message-ID: <87bljxa2sa.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Qian Cai <cai@lca.pw> writes:
> On Wed, Jul 22, 2020 at 11:59:59PM +0200, Thomas Gleixner wrote:
> SR-IOV will start trigger a warning below in this commit,
>
> [  765.434611] WARNING: CPU: 13 PID: 3377 at include/linux/entry-kvm.h:75 kvm_arch_vcpu_ioctl_run+0xb52/0x1320 [kvm]

Yes, I'm a moron. Fixed it locally and failed to transfer the fixup when
merging it. Fix below.

> [  768.221270] softirqs last disabled at (5093): [<ffffffffa1800ec2>] asm_call_on_stack+0x12/0x20
> [  768.267273] ---[ end trace 8730450ad8cfee9f ]---

Can you pretty please trim your replies?

>> ---
>> V5: Rename exit -> xfer (Sean)

<removed 200 lines of useless information>

Thanks,

        tglx
---
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 82d4a9e88908..532597265c50 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8682,7 +8682,7 @@ static int vcpu_run(struct kvm_vcpu *vcpu)
 			break;
 		}
 
-		if (xfer_to_guest_mode_work_pending()) {
+		if (__xfer_to_guest_mode_work_pending()) {
 			srcu_read_unlock(&kvm->srcu, vcpu->srcu_idx);
 			r = xfer_to_guest_mode_handle_work(vcpu);
 			if (r)

