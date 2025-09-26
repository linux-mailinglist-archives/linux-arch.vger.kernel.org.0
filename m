Return-Path: <linux-arch+bounces-13797-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AB6BA508B
	for <lists+linux-arch@lfdr.de>; Fri, 26 Sep 2025 22:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFF663BBD3D
	for <lists+linux-arch@lfdr.de>; Fri, 26 Sep 2025 20:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0476028469B;
	Fri, 26 Sep 2025 20:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="DRTJGQT3"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55500284672
	for <linux-arch@vger.kernel.org>; Fri, 26 Sep 2025 20:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758917035; cv=none; b=MARP5i7dwoiyTP1pPcLpe31dfj7G1/w7tPSQGzVkOl7mIi6f0L+PNq+3pv0duWMgqGh0wobiVFqvkLl+cl66EcdoNO03l2GbYj8j3dswmIgfGUrPYmh0L4bRFjeYfUoND7bOIJTfvmOFnLNwTsA5f12iATB9SD4Q34Of0Nj3LiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758917035; c=relaxed/simple;
	bh=R2O66mhq7TFy9y4WbsUYB5mx2K9cq8FM/Hgd8b3di8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nlt80tfuqRjsfdXiw1j9rHz3R1VannBd793VMD6Hs5oWxvmIQCcA6WisJown6joiB3PglVUuQKqXQksWGqt5psKeZQvj+hY0l1DuwUf7IV+ULTZEV8I6NNaiw7H2cZzp1Ayv2e0Npipm3o04hnjA80yDs5F8uCpC6BqLz2oVFpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=DRTJGQT3; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b551350adfaso2425774a12.3
        for <linux-arch@vger.kernel.org>; Fri, 26 Sep 2025 13:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1758917033; x=1759521833; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2JzK9TdtNq0q6HuoPTI7S0mcgrs1VMBW3yQfWD8QK0g=;
        b=DRTJGQT3fCqMgMI15Iv7O/OrLuoGqEODTM4hchVQ9jElmaFWa69KYMCKDnFMqozKRI
         yMiBno4HhYaV7kRj5jIDkRZFvK9BR/3eVXMjZf2Qr6kdsgqq7RkBU4RrNycBZ89cYSbw
         Kfw0MxlfnWWAXHOV8eEvDh8PJCen6U5b8BSHhJTjfAps1HyBo8J08i2GLf//rKuEcbk6
         1I7hbNSGCsfWZ/wZ4rwHou84rUHxmWBYVV1zj63qaUNkP8MMnJJtQH96efF3hcHM0kQt
         X29fgK/Tqr+7kNhUBhEROUSOlmAkBr1WsBGWEaqEwZWr2muYWPvQgRCQ+pyBvaYvmt4g
         AHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758917033; x=1759521833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2JzK9TdtNq0q6HuoPTI7S0mcgrs1VMBW3yQfWD8QK0g=;
        b=gu6iX9/oQa32Kwaacr8w8SMTqWDVghoGyQxt9TOJxfjs3bYpX/H6L3hlZFlIYGHuhY
         dPhcP0s7AWJ2KfjWI0uPaRgXGc/vAnCz2mq87/swPI5B9T0QTPKPAazlTd3sC0OZbkbZ
         Ut6tQ4OxmMx77JUbpUMSFvcD2DoBRHGihZPDlrw0kS+olgBm8wgAi/CL0MWz2aYnWFIP
         uzzRUVzmyfnYsMBLU7CCAXLvaCKmH5L9B/RIY69l9zYKljYje53MJ32INVboQPACUV3N
         QwMQIHsMmM0X5zDR3FL0HFspkxVbjM1vugl8MPjb2oo47s28aeCPP+7/TA9K7PIidEle
         RUXg==
X-Forwarded-Encrypted: i=1; AJvYcCX/xpgM5yleOLUH48bkK/9ro8LGgTh2bLaTYA5ghw9N7bekOlGu6k4DSUdJY35OajGtEpZ9Lm/kNA4Q@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9ArUmQElP5uI7E1w8ayqxyS+szRrFCcvTnimERf0GXHkwBwtM
	LFCdK6Tjr8x8+S49lGiEVanXuYTLUmZ5OTw+hqcBFHm/v3ElFfJDB6uZlAxdzBwbXs8=
X-Gm-Gg: ASbGncsN2lfIN5WPjel6WwHPPjgsvratXzDd7U/zl2Kb6bmrV/yhzOSeV+Ozn5P4Prx
	vqIOYiNX5mK4SlrOA5mIw7VodcvGC2/m1U7346YNJA/a2pWD8blvYCvw6XW2EabmIwIOPf8h7bi
	m87U/AXy48EscOYijOKiepw2TUvthR8VxRrg3j1yYQu5c16q20BGZvkRyhBK/iynxPMKIzwC8Y4
	o6v5udc6OOL/sWTn7D2oBl6hWbGLQ0pFVYwoR7oWETx0v0KpPASsvhq4RjT+rlNzkcdp3IQ5hU7
	eB0f6CrJJedoB1H3rhrj/OfLZDkFnUCe7/7mJrKXZUUJllO8r2iN8HWfJrMKMtLCZcD70P6fgU8
	nebSJQJoAOuSE2k9axo6eKCWpoKFfG5ev
X-Google-Smtp-Source: AGHT+IEqlWQwd3Eq3xfSDG4ZoiAYivk9596CJNNVWWuT8jIb87TOCzT2mxQOQP9H5ZgZVw/+ZQZZqA==
X-Received: by 2002:a17:902:d052:b0:27d:69de:edd3 with SMTP id d9443c01a7336-27ed49d2c63mr75874405ad.20.1758917033572;
        Fri, 26 Sep 2025 13:03:53 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed69b0685sm61092355ad.116.2025.09.26.13.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 13:03:52 -0700 (PDT)
Date: Fri, 26 Sep 2025 13:03:49 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Charles Mirabile <cmirabil@redhat.com>
Cc: Liam.Howlett@oracle.com, a.hindborg@kernel.org,
	akpm@linux-foundation.org, alex.gaynor@gmail.com,
	alexghiti@rivosinc.com, aliceryhl@google.com,
	alistair.francis@wdc.com, andybnac@gmail.com, aou@eecs.berkeley.edu,
	arnd@arndb.de, atishp@rivosinc.com, bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com, bp@alien8.de, brauner@kernel.org,
	broonie@kernel.org, charlie@rivosinc.com, cleger@rivosinc.com,
	conor+dt@kernel.org, conor@kernel.org, corbet@lwn.net,
	dave.hansen@linux.intel.com, david@redhat.com,
	devicetree@vger.kernel.org, ebiederm@xmission.com,
	evan@rivosinc.com, gary@garyguo.net, hpa@zytor.com,
	jannh@google.com, jim.shu@sifive.com, kees@kernel.org,
	kito.cheng@sifive.com, krzk+dt@kernel.org,
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	linux-riscv@lists.infradead.org, lorenzo.stoakes@oracle.com,
	lossin@kernel.org, mingo@redhat.com, ojeda@kernel.org,
	oleg@redhat.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
	peterz@infradead.org, pjw@kernel.org, richard.henderson@linaro.org,
	rick.p.edgecombe@intel.com, robh@kernel.org,
	rust-for-linux@vger.kernel.org, samitolvanen@google.com,
	shuah@kernel.org, tglx@linutronix.de, tmgross@umich.edu,
	vbabka@suse.cz, x86@kernel.org, zong.li@sifive.com
Subject: Re: [PATCH v19 00/27] riscv control-flow integrity for usermode
Message-ID: <aNbxpVddsTXL7F6T@debug.ba.rivosinc.com>
References: <20250926192919.349578-1-cmirabil@redhat.com>
 <20250926195224.351862-1-cmirabil@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250926195224.351862-1-cmirabil@redhat.com>

On Fri, Sep 26, 2025 at 03:52:24PM -0400, Charles Mirabile wrote:
>Hi -
>
>Sorry for my previous email, I realized I was mistaken...
>
>On Fri, Sep 26, 2025 at 03:29:19PM -0400, Charles Mirabile wrote:
>> Hi -
>>
>> Hoping that I got everything right with git-send-email so that this is
>> delivered alright...
>>
>> Wanted to jump in to head off a potential talking past one another /
>> miscommunication situation I see here.
>>
>> On Wed, Sep 24, 2025 at 08:36:11AM -0600, Paul Walmsley wrote:
>> > Hi,
>> >
>> > On Thu, 31 Jul 2025, Deepak Gupta wrote:
>> >
>> > [ ... ]
>> >
>> > > vDSO related Opens (in the flux)
>> > > =================================
>> > >
>> > > I am listing these opens for laying out plan and what to expect in future
>> > > patch sets. And of course for the sake of discussion.
>> > >
>> >
>> > [ ... ]
>> >
>> > > How many vDSOs
>> > > ---------------
>> > > Shadow stack instructions are carved out of zimop (may be operations) and if CPU
>> > > doesn't implement zimop, they're illegal instructions. Kernel could be running on
>> > > a CPU which may or may not implement zimop. And thus kernel will have to carry 2
>> > > different vDSOs and expose the appropriate one depending on whether CPU implements
>> > > zimop or not.
>> >
>> > If we merge this series without this, then when CFI is enabled in the
>> > Kconfig, we'll wind up with a non-portable kernel that won't run on older
>> > hardware.  We go to great lengths to enable kernel binary portability
>> > across the presence or absence of other RISC-V extensions, and I think
>> > these CFI extensions should be no different.
>>
>> That is not true, this series does not contain the VDSO changes so it can
>> be merged as is.
>
>Oops... no sorry, it looks like it does. See 19/27. I was misled by the
>cover letter which said to pick that patch separately. I completely agree
>that that needs to not be included if this is to be merged.

Yes I sent another email.

>
>>
>> >
>> > So before considering this for merging, I'd like to see at least an
>> > attempt to implement the dual-vDSO approach (or something equivalent)
>> > where the same kernel binary with CFI enabled can run on both pre-Zimop
>> > and post-Zimop hardware, with the existing userspaces that are common
>> > today.
>>
>> I agree that when the VDSO patches are submitted for inclusion they should
>> be written in a way that avoids limiting the entire kernel to either
>> pre-Zimop or post-Zimop hardware based on the config, but I think it
>> should be quite possible to perform e.g. runtime patching of the VDSO
>> to replace the Zimop instructions with nops if the config is enabled but
>> the hardware does not support Zimop.
>>
>> However, that concern should not hold up this patch series. Raise it again
>> when the VDSO patches are posted.
>
>@Deepak, would it be possible to just resend this without the VDSO patch?

No we can't do that because if cfi is opted yes and user enables it then an
indirect jump to vDSO function will result in a trap to supervisor and then
SIGSEGV.

We can compile vDSO without shadow stack option. That leaves vDSO as the only
object in address space of program open to code re-use gadgets because return
path is not protected with shadow stack (thus dilutes security properties)

>
>Or to rework as I had alluded to to check for the presense of the extension
>and remove the instructions from the VDSO at boot if it is not found?

I have responded to your earlier e-mail on this. TLDR is

If kernel is required to carry two different libraries with a need of patching
it in runtime, while rest of the userspace can't be  patched in runtime. Is it
worth the complexity to enforce on kernel? Because we then will be doing this
for every future extension which takes encodings form zimop space while rest
of the userspace really can't do that.


>
>>
>> >
>> > thanks Deepak,
>> >
>> > - Paul
>>
>> Best - Charlie
>>
>
>Best - Charlie
>

