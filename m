Return-Path: <linux-arch+bounces-218-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA1F7EB3ED
	for <lists+linux-arch@lfdr.de>; Tue, 14 Nov 2023 16:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F585B20AB0
	for <lists+linux-arch@lfdr.de>; Tue, 14 Nov 2023 15:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EF441764;
	Tue, 14 Nov 2023 15:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ABAK7Zk/"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DAD41762;
	Tue, 14 Nov 2023 15:40:30 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B16D127;
	Tue, 14 Nov 2023 07:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=jt5Y5DJTQLPOXJN8Beqfd+8guMZO4ilEpveznFWpyRQ=; b=ABAK7Zk/jGV8iInT3x/fc7EiHU
	VjcCGnxxvobpPJYs89YyUFYS07sQHPDSFrQ4xUFr1czrRIWEY/k5SO/y4FswegOpPbLDbeULIozhx
	6sNoTazWUS7MI2khNxdAfsM9ViiWOjwysrWKrQlXO6zIf6UJpgDWnmXpAv2vLTPcTZD5B3+SJIN7G
	exkjy+iUjf6iEeOqw41ZhJdWybX8wcMYLOtj8QEZkwuB6Uym1BDv97zajtq6mBhsLuJK1kYUg3etZ
	flnNcHRQ869XzWvfhzy5IR2XYF29TfIVHC46c4SFkIbIdj6toQ8o1n2D+hxDhXcgG8Av+NF2uS+or
	O+VKNhBg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1r2vWT-002X5L-2Q;
	Tue, 14 Nov 2023 15:40:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1EE74300581; Tue, 14 Nov 2023 16:40:17 +0100 (CET)
Date: Tue, 14 Nov 2023 16:40:17 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Xi Ruoyao <xry111@xry111.site>
Cc: libc-alpha@sourceware.org, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, linux-mm@kvack.org,
	linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Subject: Re: Several tst-robust* tests time out with recent Linux kernel
Message-ID: <20231114154017.GI4779@noisy.programming.kicks-ass.net>
References: <4bda9f2e06512e375e045f9e72edb205104af19c.camel@xry111.site>
 <d69d50445284a5e0d98a64862877c1e6ec22a9a8.camel@xry111.site>
 <20231114153100.GY8262@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231114153100.GY8262@noisy.programming.kicks-ass.net>

On Tue, Nov 14, 2023 at 04:31:00PM +0100, Peter Zijlstra wrote:
> On Tue, Nov 14, 2023 at 05:46:43PM +0800, Xi Ruoyao wrote:
> > On Tue, 2023-11-14 at 02:33 +0800, Xi Ruoyao wrote:
> > > Hi,
> > > 
> > > With Linux 6.7.0-rc1, several tst-robust* tests time out on x86_64:
> > > 
> > > FAIL: nptl/tst-robust1
> > > FAIL: nptl/tst-robust3
> > > FAIL: nptl/tst-robust4
> > > FAIL: nptl/tst-robust6
> > > FAIL: nptl/tst-robust7
> > > FAIL: nptl/tst-robust9
> > > 
> > > This does not happen with Linux 6.6.0.  Do you have some clue about
> > > it?
> > 
> > Bisected to the kernel commit:
> > 
> > commit 5694289ce183bc3336407a78c8c722a0b9208f9b (HEAD)
> > Author: peterz@infradead.org <peterz@infradead.org>
> > Date:   Thu Sep 21 12:45:08 2023 +0200
> > 
> >     futex: Flag conversion
> >     
> >     Futex has 3 sets of flags:
> >     
> >      - legacy futex op bits
> >      - futex2 flags
> >      - internal flags
> >     
> >     Add a few helpers to convert from the API flags into the internal
> >     flags.
> >     
> >     Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> >     Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> >     Reviewed-by: Andr<C3><A9> Almeida <andrealmeid@igalia.com>
> >     Link: https://lore.kernel.org/r/20230921105247.722140574@noisy.programming.kicks-ass.net
> 
> I can confirm. I'm also going crazy trying to figure out how this
> happens.
> 
> The below is sufficient to make it unhappy...
> 
> /me most puzzled
> 
> ---
> diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
> index b5379c0e6d6d..1a1f9301251f 100644
> --- a/kernel/futex/futex.h
> +++ b/kernel/futex/futex.h
> @@ -17,7 +17,7 @@
>   * restarts.
>   */
>  #ifdef CONFIG_MMU
> -# define FLAGS_SHARED		0x01
> +# define FLAGS_SHARED		0x10
>  #else
>  /*
>   * NOMMU does not have per process address space. Let the compiler optimize

Just the above seems sufficient.

