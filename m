Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E532E260C
	for <lists+linux-arch@lfdr.de>; Thu, 24 Oct 2019 00:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407825AbfJWWBU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Oct 2019 18:01:20 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51095 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2407794AbfJWWBU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 23 Oct 2019 18:01:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571868079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nEg2JMs7obRnwPmfQVBb4NG9WKsi5kJp3la0gsAnYkc=;
        b=JLdjMe5+uCvIxGem/FvNnJKAql0wh8ZI1xeiNnglXZNstJC5Rx3JGbUaP0Z5jwo+eWk0eH
        auJf1VhqYBRK7XUoIDLepJQufNyizuv8QT2wtw7Cmk4bJnZDhkMLxV1vNqghXhbql65Knn
        Lv9A9/sVLCL8Xcw76zsMOYaIXXMCu9M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-Gi_XQU_ZPV2zJxaYVWjtRQ-1; Wed, 23 Oct 2019 18:01:15 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23F0D107AD31;
        Wed, 23 Oct 2019 22:01:14 +0000 (UTC)
Received: from treble (ovpn-121-225.rdu2.redhat.com [10.10.121.225])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E8FB919C77;
        Wed, 23 Oct 2019 22:01:11 +0000 (UTC)
Date:   Wed, 23 Oct 2019 17:01:09 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Will Deacon <will@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-arch@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [patch V2 05/17] x86/traps: Make interrupt enable/disable
 symmetric in C code
Message-ID: <20191023220109.jmbrluyjxenblcij@treble>
References: <20191023122705.198339581@linutronix.de>
 <20191023123118.084086112@linutronix.de>
MIME-Version: 1.0
In-Reply-To: <20191023123118.084086112@linutronix.de>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: Gi_XQU_ZPV2zJxaYVWjtRQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 23, 2019 at 02:27:10PM +0200, Thomas Gleixner wrote:
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -1500,10 +1500,13 @@ static noinline void
>  =09=09return;
> =20
>  =09/* Was the fault on kernel-controlled part of the address space? */
> -=09if (unlikely(fault_in_kernel_space(address)))
> +=09if (unlikely(fault_in_kernel_space(address))) {
>  =09=09do_kern_addr_fault(regs, hw_error_code, address);
> -=09else
> +=09} else {
>  =09=09do_user_addr_fault(regs, hw_error_code, address);
> +=09=09if (regs->flags & X86_EFLAGS_IF)
> +=09=09=09local_irq_disable();
> +=09}

The corresponding irq enable is in do_user_addr_fault(), why not do the
disable there?

--=20
Josh

