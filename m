Return-Path: <linux-arch+bounces-1228-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9221C821AF6
	for <lists+linux-arch@lfdr.de>; Tue,  2 Jan 2024 12:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0596D1F227BF
	for <lists+linux-arch@lfdr.de>; Tue,  2 Jan 2024 11:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A11E572;
	Tue,  2 Jan 2024 11:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="J0ZzP+oE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kG2JZIXk"
X-Original-To: linux-arch@vger.kernel.org
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6A1E555;
	Tue,  2 Jan 2024 11:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 890A93200AD5;
	Tue,  2 Jan 2024 06:30:21 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 02 Jan 2024 06:30:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1704195021;
	 x=1704281421; bh=h3JvgInG7Ve5RiimZ8l2qqQlcPTAgW2uluafkfImiMg=; b=
	J0ZzP+oENC5diPXzLG51ke/34Q4eGEG/BZdJpS2ydH8WJEaBlzGtV/fF2DFmQcM1
	zFeZLkK3EnU26TOYyIIrE1PcDocj1PX7tLakPL++r2nsa9YZK0CuMfPM05VZev5p
	PwnHw3+SpjQkdLsx4kZnNesNS+xZ7MlJQeRrhxvXtv39q+Sgtxvrf4fc8B1YNh3H
	9eXlnMj6CygiRY4Vpb105G1kDzQ2U2vPgUH4rt8iMzEbYCS67H+NguMLOexH80+y
	Am/+o+vqC6whc99P6hC+lFBFK6/oglggTWUDxW17eRPtmLjmDf7OFhfYXIdNEiAs
	Bi6OgB3KwcVWqEhXLLvH8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1704195021; x=
	1704281421; bh=h3JvgInG7Ve5RiimZ8l2qqQlcPTAgW2uluafkfImiMg=; b=k
	G2JZIXkFwCe70RI3PcafnLr3j8GF7AFn3rI2Re525QhVWVQBhtTnh5+bq4BU1Rox
	2yHZaPE7w+NO79R6NB9AV84egZjUFHEKbkCBErjw9Tv6+zql9ImL//LBu7GVHmFA
	NtLGRyuqIcPYO6mq1iqHw3o+/SucXcsWcHi3snwlHJWpf1pRl68BeVUxWbNJAZqg
	P4ZspZysFW/TCn3o9hMiS/Fd92IGdqiFa8SY6CgZHmHcm25DoOzH/5LmtAkCkImx
	tK0ydany5PLkP+OQJvA+vUIQU+R74CZQVww2wKQrzz3vIV72/DtLyxGa5lHTOkaJ
	QmPQlmfQcgtZSRCdoxJXw==
X-ME-Sender: <xms:zPOTZYbia3SVWJYS8m8t0xhQQmG5qxhCQEDdePwlqRYd5rFgHBsptw>
    <xme:zPOTZTbz8c5TJc26OjAIEaFEyPCVZfgXNOwthuivPvsdWvJgPi9Ds_2xU1RpTv0rZ
    euBZu3VZ0n4EM-pjQs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdegvddgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:zPOTZS9qr36iU_GgWLmZeUyApfi00Dkasyl-QBLvNglpt92w1P3Alg>
    <xmx:zPOTZSrcTXTA2ebg43ik4TsfMMW6enuXHga81xYxylPIAlacJr2LcA>
    <xmx:zPOTZTo-8BflwpnXhBimnXIcYwhytNx9IyvuHHlEN6NIElwzSscq4g>
    <xmx:zfOTZfo2D2j50BQd46AH5fFoakLl1k_C8rOLiz15xgb-hy4X2BSlCg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id F1587B6008D; Tue,  2 Jan 2024 06:30:19 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1364-ga51d5fd3b7-fm-20231219.001-ga51d5fd3
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <84d8e9d7-09ce-4781-8dfa-a74bb0955ae8@app.fastmail.com>
In-Reply-To: 
 <CAMuE1bF0Hho4VwO6w3f+9z3j5TtscYzuAjj10MFt2mZXG2P8dQ@mail.gmail.com>
References: <20231228122411.3189-1-maimon.sagi@gmail.com>
 <f254c189-463e-43a3-bc09-9a8869ebf819@app.fastmail.com>
 <CAMuE1bF0Hho4VwO6w3f+9z3j5TtscYzuAjj10MFt2mZXG2P8dQ@mail.gmail.com>
Date: Tue, 02 Jan 2024 12:29:59 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Sagi Maimon" <maimon.sagi@gmail.com>
Cc: "Richard Cochran" <richardcochran@gmail.com>,
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
 "Mark Rutland" <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 Netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH v3] posix-timers: add multi_clock_gettime system call
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 31, 2023, at 17:00, Sagi Maimon wrote:
> On Fri, Dec 29, 2023 at 5:27=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> =
wrote:

>> > +struct __ptp_multi_clock_get {
>> > +     unsigned int n_clocks; /* Desired number of clocks. */
>> > +     unsigned int n_samples; /* Desired number of measurements per=
 clock. */
>> > +     clockid_t clkid_arr[MULTI_PTP_MAX_CLOCKS]; /* list of clock I=
Ds */
>> > +     /*
>> > +      * Array of list of n_clocks clocks time samples n_samples ti=
mes.
>> > +      */
>> > +     struct  __kernel_timespec ts[MULTI_PTP_MAX_SAMPLES][MULTI_PTP=
_MAX_CLOCKS];
>> > +};
>>
>> The fixed size arrays here seem to be an unnecessary limitation,
>> both MULTI_PTP_MAX_SAMPLES and MULTI_PTP_MAX_CLOCKS are small
>> enough that one can come up with scenarios where you would want
>> a higher number, but at the same time the structure is already
>> 808 bytes long, which is more than you'd normally want to put
>> on the kernel stack, and which may take a significant time to
>> copy to and from userspace.
>>
>> Since n_clocks and n_samples are always inputs to the syscall,
>> you can just pass them as register arguments and use a dynamically
>> sized array instead.
>>
> Both MULTI_PTP_MAX_SAMPLES and MULTI_PTP_MAX_CLOCKS are enough of any
> usage we can think of,
> But I think you are right, it is better to use a dynamically sized
> array for future use, plus to use less stack memory.
> On patch v4 a dynamically sized array will be used .
> I leaving both MULTI_PTP_MAX_SAMPLES and MULTI_PTP_MAX_CLOCKS but
> increasing their values, since there should be some limitation.

I think having an implementation specific limit in the kernel is
fine, but it would be nice to hardcode that limit in the API.

If both clkidarr[] and ts[] are passed as pointer arguments
in registers, they can be arbitrarily long in the API and
still have a documented maximum that we can extend in the
future without changing the interface.

>> It's not clear to me what you gain from having the n_samples
>> argument over just calling the syscall repeatedly. Does
>> this offer a benefit for accuracy or is this just meant to
>> avoid syscall overhead.
> It is mainly to avoid syscall overhead which also slightly
> improve the accuracy.

This is not a big deal as far as I'm concerned, but it
would be nice to back this up with some numbers if you
think it's worthwhile, as my impression is that the effect
is barely measurable: my guess would be that the syscall
overhead is always much less than the cost for the hardware
access.

>> On the other hand, this will still give less accuracy than the
>> getcrosststamp() callback with ioctl(PTP_SYS_OFFSET_PRECISE),
>> so either the last bit of accuracy isn't all that important,
>> or you need to refine the interface to actually be an
>> improvement over the chardev.
>>
> I don't understand this comment, please explain.
> The ioctl(PTP_SYS_OFFSET_PRECISE) is one specific case that can be
> done by multi_clock_gettime syscall (which cover many more cases)
> Plus the ioctl(PTP_SYS_OFFSET_PRECISE) works only on drivers that
> support this feature.

My point here is that on drivers that do support
PTP_SYS_OFFSET_PRECISE, the extra accuracy should be maintained
by the new interface, ideally in a way that does not have any
other downsides.

I think Andy's suggestion of exposing time offsets instead
of absolute times would actually achieve that: If the
interface is changed to return the offset against
CLOCK_MONOTONIC, CLOCK_MONOTONIC_RAW or CLOCK_BOOTTIME
(not sure what is best here), then the new syscall can use
getcrosststamp() where supported for the best results or
fall back to gettimex64() or gettime64() otherwise to
provide a consistent user interface.

Returning an offset would also allow easily calculating an
average over multiple calls in the kernel, instead of
returning a two-dimensional array.

    Arnd

