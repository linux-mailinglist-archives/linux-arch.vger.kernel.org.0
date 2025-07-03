Return-Path: <linux-arch+bounces-12558-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 123C1AF7E48
	for <lists+linux-arch@lfdr.de>; Thu,  3 Jul 2025 18:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A34B1CA159A
	for <lists+linux-arch@lfdr.de>; Thu,  3 Jul 2025 16:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A3A24C09E;
	Thu,  3 Jul 2025 16:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oop0y/en"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46534258CDC;
	Thu,  3 Jul 2025 16:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751561913; cv=none; b=a2Pd17K+X6yfzu8yOEPHoXA5p0LVunffEGeH0CPo7p2/AVIxQYrCStAogL74tWlIWPWL/uenPx0Q40r29vpSSBrMjyUoVvrDTSzR/TVCHlis+Lezf6X3twtvw5lQaq/aik6jtkfLNcSRHGLw0qnaUXdlpVFfdsUcs/ppvDNN8g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751561913; c=relaxed/simple;
	bh=exFRltBZ/xeP4dmW57mF1WF3LqGWGFdS7kYw9lBwwDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qsM52l8Bw9JOcWS/jvuaZh1i4Gh9GhtL/gTDoR0arXvJj/OKfFkvCHTa3QsxfLBlQWbyZulZj2RihUcTkbrvRpG7U5UNgajEpfzC/lhDH33I+K8rRrJtViQmqA3OVVsej3T6xJKLdH+OZSJ4YmOLGk6T8aTT3I8zOm2+qIiLVOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oop0y/en; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7490acf57b9so182320b3a.2;
        Thu, 03 Jul 2025 09:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751561911; x=1752166711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vaMWvr/LwOy/DPFt7E6Ou21vzc6EQJXl4tZisI0lbDw=;
        b=Oop0y/enecvcm4oZUec/pYBJ/NUE9GsnZlq0boUrxuJVwxnjW1+9HXHW2H8P8DTX2I
         hKg3N8Yedd7HD91N0Z4wUoBM1+y3ndBGJSioIYZ1IJCRZOY6oyfCbN91yfJy+Cv/E+ed
         nWE9XCamHnhI+E2Y+lC/2qkck/a4kE2fHgumsYiZ5MiOKm49nrofNnQBxI20g8k1zCDB
         pe3gbhzJ1cH2SwdZ8QCsFlH1gtynHnRY7LB1TW14cVJBKI+AM+fDgAJutDwQ3/Z0ASQQ
         vtaTciUQCwMextYdD53FhTv9ew/n0qSwYmIsZ7qJepqFLRdBBbZ5xZHep/EqQ00a948m
         OwhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751561911; x=1752166711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vaMWvr/LwOy/DPFt7E6Ou21vzc6EQJXl4tZisI0lbDw=;
        b=G75LIXz/i4siGZ0R0nRDhX1R58G1XN9+U4OT+cwXs1Gc/RKXL9bstnhsVA8HbLnFr9
         WHECh/jVZs9ZsY7kvMHFItIUXiYFvjMmbItf7ZWM3BjND7cWk2eL4uquq73+Bwc9cCD1
         vtxt8Y60ySI4cgho7PMW9bBZBVKN0UN7S1psy1cttBwdbn8It21PxQUF5DD36ATC7aL3
         mbMaT7d/WwV/GKMJn0ymSmHqKKKJl8CNjxZuH8JB2CmD6ENugDCklj7qpolkN5Ycz7EZ
         V5ww7AJnzmRVCDZkdRUvEfAJz+9QjKMwstlNHIBOR9cQ+elaF97jK8VX2sK/U5+dGvDI
         Btsg==
X-Forwarded-Encrypted: i=1; AJvYcCW25mbelTh0WwJRgvtTLck++Vcjlig7uWfnzchr5ik0X+aePZZ+lbvuWu3OvN8kUn0FpAoZP7ZFMteOmkFD@vger.kernel.org, AJvYcCX+CHnw2RhPEC9C5jsXJZZ4W5zosiEPBiduBtZPTRWlHSLz6LKcZfQE/bHcX3B/m4lPckO3oxjQcmMv@vger.kernel.org
X-Gm-Message-State: AOJu0YxP5h0qtpHjyOFg5Xwqo6repb+tgsgmAIIECrLtF2eV+yq8+SjE
	I443cCSQm2P1miJa0UziJ3QZ0arA2u+2Y+8wHvHrga4/6tHmH0p/tNgC
X-Gm-Gg: ASbGncuJl4gJ/3sAIT7sBqhyH/SYqQ9Gx6ZzRzdHR/6f2dtSdpKkRBkZRnKAESKbKmf
	1S7ZzJA+M7lNOYzWqjS6U6ap++6VNOmD397J1Y3HqEFerCd8YAYGciv0NrZwGF0a6RgYw0lMo4L
	BwEO7VH2fUh2nckW7OUVdkoOH/LCjjwdeShJUqQd2zqSlsBWlnVr2gKbFuLX3MycB5k82AM+G3e
	XQPRnkKVvWQ53Z179QB0O4q2KRRUlWNNuT6OW2WVThqhEcBIHndEFctzN2nus77m1VMjbHGzg7Z
	1QoOxufHCe9Qhsdqb87UEqIPYZgC2J0bpYYJ2kYWs7kce/0icp+cbItMmT0BVA==
X-Google-Smtp-Source: AGHT+IHBLGDwR+y0/xmd0/Az+y9ZiXd4ddJjrXR1M7ccldKrPt5j62yq3oXJYN+rOaUM3mayriZ9mQ==
X-Received: by 2002:a05:6a20:2d06:b0:1f5:92ac:d6a1 with SMTP id adf61e73a8af0-224096f8835mr7006936637.4.1751561911487;
        Thu, 03 Jul 2025 09:58:31 -0700 (PDT)
Received: from localhost ([216.228.127.129])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee4755c5sm111522a12.20.2025.07.03.09.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 09:58:30 -0700 (PDT)
Date: Thu, 3 Jul 2025 12:58:28 -0400
From: Yury Norov <yury.norov@gmail.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: cp0613@linux.alibaba.com, alex@ghiti.fr, aou@eecs.berkeley.edu,
	arnd@arndb.de, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux@rasmusvillemoes.dk, palmer@dabbelt.com,
	paul.walmsley@sifive.com
Subject: Re: [PATCH 2/2] bitops: rotate: Add riscv implementation using Zbb
 extension
Message-ID: <aGa2tKXJutz_Gvsi@yury>
References: <aGLA78usaJOnpols@yury>
 <20250701124737.687-1-cp0613@linux.alibaba.com>
 <aGQprv3HTplw9r-q@yury>
 <20250702111135.37854d1b@pumpkin>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702111135.37854d1b@pumpkin>

On Wed, Jul 02, 2025 at 11:11:35AM +0100, David Laight wrote:
> On Tue, 1 Jul 2025 14:32:14 -0400
> Yury Norov <yury.norov@gmail.com> wrote:
> 
> I'd not worry about rotates of 8 bits or more (for ror8).
> They can be treated as 'undefined behaviour' under the assumption they don't happen.

Good for you. But generic implementation is safe against overflowing
the shift, so the arch must be safe as well.

> The 'generic' version needs them to get gcc to generate a 'rorb' on x86.
> The negated shift needs masking so that clang doesn't throw the code away when
> the value is constant.

...

> > > I compared the performance of ror8 (zbb optimized) and generic_ror8 on the XUANTIE C908
> > > by looping them. ror8 is better, and the advantage of ror8 becomes more obvious as the
> > > number of iterations increases. The test code is as follows:
> > > ```
> > > 	u8 word = 0x5a;
> > > 	u32 shift = 9;
> > > 	u32 i, loop = 100;
> > > 	u8 ret1, ret2;
> > > 
> > > 	u64 t1 = ktime_get_ns();
> > > 	for (i = 0; i < loop; i++) {
> > > 		ret2 = generic_ror8(word, shift);
> > > 	}
> > > 	u64 t2 = ktime_get_ns();
> > > 	for (i = 0; i < loop; i++) {
> > > 		ret1 = ror8(word, shift);
> > > 	}
> > > 	u64 t3 = ktime_get_ns();
> > > 
> > > 	pr_info("t2-t1=%lld t3-t2=%lld\n", t2 - t1, t3 - t2);
> > > ```  
> > 
> > Please do the following:
> > 
> > 1. Drop the generic_ror8() and keep only ror/l8()
> > 2. Add ror/l16, 34 and 64 tests.
> > 3. Adjust the 'loop' so that each subtest will take 1-10 ms on your hw.
> 
> That is far too many iterations.
> You'll get interrupts dominating the tests.

That's interesting observation. Can you show numbers for your
hardware?

> The best thing is to do 'just enough' iterations to get a meaningful result,
> and then repeat a few times and report the fastest (or average excluding
> any large outliers).
> 
> You also need to ensure the compiler doesn't (or isn't allowed to) pull
> the contents of the inlined function outside the loop - and then throw
> the loop away,

Not me - Chen Pei needs. I wrote __always_used for it. It should
help.
 
> The other question is whether any of it is worth the effort.
> How many ror8() and ror16() calls are there?
> I suspect not many.

I'm not a RISC-V engineer, and I can't judge how they want to use the
functions. This doesn't bring significant extra burden on generic
side, so I don't object against arch ror8() on RISCs.

> Improving the generic ones might be worth while.
> Perhaps moving the current versions to x86 only.
> (I suspect the only other cpu with byte/short rotates is m68k)
> 
> 	David

