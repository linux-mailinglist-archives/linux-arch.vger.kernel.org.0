Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E592E2564
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2019 23:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404415AbfJWVbT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Oct 2019 17:31:19 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31892 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391179AbfJWVbT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 23 Oct 2019 17:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571866278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mKJAxNSEFHg5g84xz0cpNjTeNjjB7lw6asiNQyLDQPQ=;
        b=SqRgbd3WkfE5JLLfs+dl7YX6BLz/gib8/XBtzdpx3779ptUpSLcOEJAQiWx9bYKYwNGl4U
        vLiHWxX4AauD3Yeczf8v4RPdeDWoD6+r41OVtVf7ZMsWzw37NfgETOAsghfJSpq8/q93xf
        BekT0lpBaX2h6A0eRi1tNSa/SSmRnPE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-HutMCuPvOW-CVyb0LqMZww-1; Wed, 23 Oct 2019 17:31:14 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 136CA1800D6B;
        Wed, 23 Oct 2019 21:31:12 +0000 (UTC)
Received: from treble (ovpn-121-225.rdu2.redhat.com [10.10.121.225])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C19681001E75;
        Wed, 23 Oct 2019 21:31:09 +0000 (UTC)
Date:   Wed, 23 Oct 2019 16:31:07 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Will Deacon <will@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-arch@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [patch V2 03/17] x86/traps: Remove pointless irq enable from
 do_spurious_interrupt_bug()
Message-ID: <20191023213107.m7ishskghswktspp@treble>
References: <20191023122705.198339581@linutronix.de>
 <20191023123117.871608831@linutronix.de>
MIME-Version: 1.0
In-Reply-To: <20191023123117.871608831@linutronix.de>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: HutMCuPvOW-CVyb0LqMZww-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 23, 2019 at 02:27:08PM +0200, Thomas Gleixner wrote:
> That function returns immediately after conditionally reenabling interrup=
ts which
> is more than pointless and requires the ASM code to disable interrupts ag=
ain.
>=20
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/kernel/traps.c |    1 -
>  1 file changed, 1 deletion(-)
>=20
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -871,7 +871,6 @@ do_simd_coprocessor_error(struct pt_regs
>  dotraplinkage void
>  do_spurious_interrupt_bug(struct pt_regs *regs, long error_code)
>  {
> -=09cond_local_irq_enable(regs);
>  }

I think we can just remove this handler altogether.  The Intel and AMD
manuals say vector 15 (X86_TRAP_SPURIOUS) is reserved.

--=20
Josh

