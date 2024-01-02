Return-Path: <linux-arch+bounces-1227-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4686C821997
	for <lists+linux-arch@lfdr.de>; Tue,  2 Jan 2024 11:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B07261F21F7F
	for <lists+linux-arch@lfdr.de>; Tue,  2 Jan 2024 10:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBD7D285;
	Tue,  2 Jan 2024 10:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="KrGwThx6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yCJtXhSv"
X-Original-To: linux-arch@vger.kernel.org
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DF8D26A;
	Tue,  2 Jan 2024 10:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 724143200AA7;
	Tue,  2 Jan 2024 05:22:20 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 02 Jan 2024 05:22:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1704190939; x=1704277339; bh=O5yLhV8zmF
	WtIe0QaQT0/V/5UdgS9me4EMoCkdYDikY=; b=KrGwThx6YXdclupiKcYJYlxPSt
	+A8sWnmi1MxdWKJmbRzR1T6imtppicgaij0JIptC/R+RLAzq9lSApvxlX25XfeVe
	dfaEZITwgXVVB5h2lfwhpkEiCh3JT3GkSeadw+vokMCVvJ2nFTzyJREv5yYkNbLO
	KBP/WqJJQpSTVDi4cCQaMua7OaUmzjGGnkgxQaNc6rfM0pOpsypZWAludUtla3zg
	+DuGxgprnEl6lo0urVubtxkZ9CXls5lTuKZRoZJ5kJwUWU8m6ZFJHl3/mTCDmVmS
	QTZpTAzSahP+msdRuhv1/S0+aBwq7X0MG7/fv+DTvnobGVcP4ROn9q1dPMiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704190939; x=1704277339; bh=O5yLhV8zmFWtIe0QaQT0/V/5UdgS
	9me4EMoCkdYDikY=; b=yCJtXhSvyflVrUws+fa/bM33dI4bDnrhF6soiPApcj3d
	5AVMkOa/fDRYFuwi6inmlG1zwwz0+NEt6WH+bAA+QF4CknS+EWWH8HqE+8jTFXwm
	trUIK4+Oc2GEv7AbEi1/rdgYyHZ5TKvLjbJU73xZYLd/km3cUft1dprp+kTMpieE
	Ug5zm6bLp3R7y13Pog6rO/3gKsZJiOwM2tOODAeXzOsA1Wc7GWKjnv7i7I+7kSfu
	OBVfhqHjLJLGKOgHKJy7rRi0k+7ULoL9KtPupjRl8mAmzWfMUKA3HS9jEzNr7slD
	UkusPYfWMoHa1R6J4X/LxFfaK9wGT4VujX3N69fQMg==
X-ME-Sender: <xms:2uOTZQn9UCs2vVuT7UGy3_BH0BnYtYREux3vaj3C8BmeJUPDg84zmw>
    <xme:2uOTZf3uE48B9MAdt_cz6RJ4rm_XrDgCY5dSm4uSpyJpvsq2cmNAABy4jQCzwcQJG
    xEyxOlLmGKeH97AaSE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdegvddguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:2-OTZepn0ILM77bxWRHaaG6m59lN9X6lXe5vi1288LQuCunNwdNdaQ>
    <xmx:2-OTZcnms-wK-w4o1G-dzUI2TSYapRgzc2KQFKrXyDqurRG04LMmLw>
    <xmx:2-OTZe2dgbWI0YCJN55Qfe_uTT4O87_O31BcCPto9Wg-FchzHofNtg>
    <xmx:2-OTZYWAjf4UAJgjkaUEIpBfdheN_e3AB5tZ4-xJZXGQmvhMDTU_0A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id DBAC6B6008D; Tue,  2 Jan 2024 05:22:18 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1364-ga51d5fd3b7-fm-20231219.001-ga51d5fd3
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <86fcb951-67e0-4f1d-a441-f3b4bcce8210@app.fastmail.com>
In-Reply-To: <20240102091855.70418-1-maimon.sagi@gmail.com>
References: <20240102091855.70418-1-maimon.sagi@gmail.com>
Date: Tue, 02 Jan 2024 11:21:52 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Sagi Maimon" <maimon.sagi@gmail.com>,
 "Richard Cochran" <richardcochran@gmail.com>,
 "Andy Lutomirski" <luto@kernel.org>, datglx@linutronix.de,
 "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Johannes Weiner" <hannes@cmpxchg.org>,
 "Sohil Mehta" <sohil.mehta@intel.com>,
 "Rick Edgecombe" <rick.p.edgecombe@intel.com>,
 "Nhat Pham" <nphamcs@gmail.com>, "Palmer Dabbelt" <palmer@sifive.com>,
 "Kees Cook" <keescook@chromium.org>, "Alexey Gladkov" <legion@kernel.org>,
 "Mark Rutland" <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, Netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH v5] posix-timers: add multi_clock_gettime system call
Content-Type: text/plain

On Tue, Jan 2, 2024, at 10:18, Sagi Maimon wrote:
> Some user space applications need to read some clocks.
> Each read requires moving from user space to kernel space.
> The syscall overhead causes unpredictable delay between N clocks reads
> Removing this delay causes better synchronization between N clocks.
>
> Introduce a new system call multi_clock_gettime, which can be used to measure
> the offset between multiple clocks, from variety of types: PHC, virtual PHC
> and various system clocks (CLOCK_REALTIME, CLOCK_MONOTONIC, etc).
> The offset includes the total time that the driver needs to read the clock
> timestamp.
>
> New system call allows the reading of a list of clocks - up to PTP_MAX_CLOCKS.
> Supported clocks IDs: PHC, virtual PHC and various system clocks.
> Up to PTP_MAX_SAMPLES times (per clock) in a single system call read.
> The system call returns n_clocks timestamps for each measurement:
> - clock 0 timestamp
> - ...
> - clock n timestamp
>
> Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
> ---
>  Changes since version 4:
>  - fix error  : 'struct __ptp_multi_clock_get' declared inside parameter list 
>    will not be visible outside of this definition or declaration

I usually put all the changes for previous versions in a
list here, it helps reviewers.

The changes you made for previous versions all look good
to me, but I think there is still a few things worth
considering. I'll also follow up on the earlier threads.

> +#define MULTI_PTP_MAX_CLOCKS 32 /* Max number of clocks */
> +#define MULTI_PTP_MAX_SAMPLES 32 /* Max allowed offset measurement samples. */
> +
> +struct __ptp_multi_clock_get {
> +	unsigned int n_clocks; /* Desired number of clocks. */
> +	unsigned int n_samples; /* Desired number of measurements per clock. */
> +	clockid_t clkid_arr[MULTI_PTP_MAX_CLOCKS]; /* list of clock IDs */
> +	/*
> +	 * Array of list of n_clocks clocks time samples n_samples times.
> +	 */
> +	struct  __kernel_timespec ts[MULTI_PTP_MAX_SAMPLES][MULTI_PTP_MAX_CLOCKS];
> +};

Since you now access each member individually, I think it
makes more sense here to just pass these as four
register arguments. It helps with argument introspection,
avoids a couple of get_user(), and lets you remove the fixed
array dimensions.

> +SYSCALL_DEFINE1(multi_clock_gettime, struct __ptp_multi_clock_get 
> __user *, ptp_multi_clk_get)
> +{
> +	const struct k_clock *kc;
> +	struct timespec64 *kernel_tp;
> +	struct timespec64 *kernel_tp_base;
> +	unsigned int n_clocks; /* Desired number of clocks. */
> +	unsigned int n_samples; /* Desired number of measurements per clock. 
> */
> +	unsigned int i, j;
> +	clockid_t clkid_arr[MULTI_PTP_MAX_CLOCKS]; /* list of clock IDs */
> +	int error = 0;
> +
> +	if (copy_from_user(&n_clocks, &ptp_multi_clk_get->n_clocks, 
> sizeof(n_clocks)))
> +		return -EFAULT;
> +	if (copy_from_user(&n_samples, &ptp_multi_clk_get->n_samples, 
> sizeof(n_samples)))

If these remain as struct members rather than register arguments,
you should use get_user() instead of copy_from_user().

> +	kernel_tp_base = kmalloc_array(n_clocks * n_samples,
> +				       sizeof(struct timespec64), GFP_KERNEL);
> +	if (!kernel_tp_base)
> +		return -ENOMEM;

To be on the safe side regarding possible data leak, maybe use
kcalloc() instead of kmalloc_array() here.

> +	kernel_tp = kernel_tp_base;
> +	for (j = 0; j < n_samples; j++) {
> +		for (i = 0; i < n_clocks; i++) {
> +			if (put_timespec64(kernel_tp++, (struct __kernel_timespec __user *)
> +					&ptp_multi_clk_get->ts[j][i])) {

I think the typecast here can be removed.

      Arnd

