Return-Path: <linux-arch+bounces-1982-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 948CA845EDC
	for <lists+linux-arch@lfdr.de>; Thu,  1 Feb 2024 18:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B58028AADC
	for <lists+linux-arch@lfdr.de>; Thu,  1 Feb 2024 17:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91957C6D4;
	Thu,  1 Feb 2024 17:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PJ+teQ/7"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9780A7C6DF
	for <linux-arch@vger.kernel.org>; Thu,  1 Feb 2024 17:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706809736; cv=none; b=oGfT35H0+GNA0zmDNgRFwb8XHQ4hwISceKj70eELmIdKKj0tu2j06NCetNycKSJXYQwKchDCMnbWIqNf6rDfbHtTm4x1i7jU8ved7X8C81eT0OXHPvN7BCkou2qHkW730XBxN+T7tkSIgmjFpFF8DB5XjJD2fNrhtIxX6ks+A00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706809736; c=relaxed/simple;
	bh=Grgjp5eNCkIOqriHl4Vdp4WOeqDo3ixIM5+oKQyWaZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iBi33fupgjEUUZJRdvj5/HI4e1ezkpALmCqSgLvmBcr5cOOLgBGwh1Xyb44c5S7fWLWVyQzWCYbNUEAVz2n6zbCR1KMwqk76k+zbW9EIcku/pia8oAKYhxg41nw0ZWBOEJ2oMyazRO5+c/0bve5Wj7kp241meBRMlCTDoFq7Zz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PJ+teQ/7; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55f2b0c5ae9so1612363a12.2
        for <linux-arch@vger.kernel.org>; Thu, 01 Feb 2024 09:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706809732; x=1707414532; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p1AVzZb0NYW5XZP6aUzDR5tG81geNwdMzzdRW+0+Img=;
        b=PJ+teQ/7o8eRX2hdhyG2FyPpKaTaaTrzhYClR0jlXTgzwhBxrJT9yFjzS3nsheOm3B
         /deChve6FW8eoPkYJquJg8QpUmJX0AgxWTPwY0J9HxFf3Spf4ofSXwT1sczs/2SwnWUB
         noumZTKpSqh5Qy+jr2eg4w1oPGi5l/hV8Wh8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706809732; x=1707414532;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p1AVzZb0NYW5XZP6aUzDR5tG81geNwdMzzdRW+0+Img=;
        b=JE7pK4N2hcbT7YjNez9oMPccyyMJgR1gcBqFkNErGRzeUCM03Spcx3C3W3K0BZS5pA
         rHR1lef9bF05MV1TcTJeB0SCtMyXVnivstD6alHXL6eBYTFoMCHw6dvuq1lsJeQqc/e3
         qMUwyDN9tcaETvTR9mguuyp0RMZ/+vJZ9ul+2PYmYtJL25KYLsklI6ri2g2MXRU0lfDF
         1NNExVAyKeldUd41sztNUitXRhcHKvuT19ey3qw8i/tUr2s4nWr4vlpBMxfZTcW3HSAM
         xq3F65ki4Eua89xEzIb10996ddec/i/j1wVjWSmB1LIiqB0VNiQqUo57aV7v3C20nJlN
         pIwA==
X-Gm-Message-State: AOJu0YwtnJvJe8C0jE6FaZduCf6At6L1CPtZnh/mrqeJkkH8dXP0TltI
	dt97RmVLelwXl2FVO0HBDvjoZy+h0xiWX74+hvdp1kkouH9XcukPUhG6DspN+LmExMU/ItEs5DC
	aUn3xxw==
X-Google-Smtp-Source: AGHT+IGzqloL7VMQs1zQt3FQjyfULadDPksssVogHS0nWQufyUtyhPjhsnxTWKB1l2hhDFjWWz2caw==
X-Received: by 2002:a05:6402:5213:b0:55f:7fe9:c567 with SMTP id s19-20020a056402521300b0055f7fe9c567mr4788874edd.1.1706809732510;
        Thu, 01 Feb 2024 09:48:52 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVkzJMTBJe2Ab4wO3TAGrebkfeN3B8qfa5tSein/DTYEjI3n+cs2vraSeUdoSTG8ribgPopDHyb6ayO/MbbtsCr4/toQvk6k2BxSg==
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id es27-20020a056402381b00b0055c60ba9640sm24539edb.77.2024.02.01.09.48.51
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 09:48:52 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55f0b2c79cdso1586644a12.3
        for <linux-arch@vger.kernel.org>; Thu, 01 Feb 2024 09:48:51 -0800 (PST)
X-Received: by 2002:aa7:d6d1:0:b0:55f:1a79:8b8d with SMTP id
 x17-20020aa7d6d1000000b0055f1a798b8dmr3775037edr.3.1706809731384; Thu, 01 Feb
 2024 09:48:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201-exception_ip-v1-0-aa26ab3ee0b5@flygoat.com>
In-Reply-To: <20240201-exception_ip-v1-0-aa26ab3ee0b5@flygoat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 1 Feb 2024 09:48:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=whUp8cDxLr3EKZ1e-83+MJcazjtmpjmXGG-Y+7xvRqoRg@mail.gmail.com>
Message-ID: <CAHk-=whUp8cDxLr3EKZ1e-83+MJcazjtmpjmXGG-Y+7xvRqoRg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Handle delay slot for extable lookup
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Ben Hutchings <ben@decadent.org.uk>, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	Xi Ruoyao <xry111@xry111.site>
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Feb 2024 at 07:46, Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
>  arch/alpha/include/asm/ptrace.h        | 1 +
>  arch/arc/include/asm/ptrace.h          | 1 +
>  arch/arm/include/asm/ptrace.h          | 1 +
>  arch/csky/include/asm/ptrace.h         | 1 +
>  arch/hexagon/include/uapi/asm/ptrace.h | 1 +
>  arch/loongarch/include/asm/ptrace.h    | 1 +
>  arch/m68k/include/asm/ptrace.h         | 1 +
>  arch/microblaze/include/asm/ptrace.h   | 3 ++-
>  arch/mips/include/asm/ptrace.h         | 2 ++
>  arch/mips/kernel/ptrace.c              | 7 +++++++
>  arch/nios2/include/asm/ptrace.h        | 3 ++-
>  arch/openrisc/include/asm/ptrace.h     | 1 +
>  arch/parisc/include/asm/ptrace.h       | 1 +
>  arch/s390/include/asm/ptrace.h         | 1 +
>  arch/sparc/include/asm/ptrace.h        | 2 ++
>  arch/um/include/asm/ptrace-generic.h   | 1 +
>  mm/memory.c                            | 4 ++--
>  17 files changed, 28 insertions(+), 4 deletions(-)

The only user right now is mm/memory.c, and it doesn't even include
<asm/ptrace.h>, but instead does the proper thing and includes
<linux/ptrace.h>

So please make <linux/ptrace.h> just do

     #ifndef exception_ip
        #define exception_ip(x) instruction_pointer(x)
    #endif

and all those non-MIPS architecture updates should just go away, and
the diffstat should look something like

  arch/mips/kernel/ptrace.c          | 7 +++++++
  include/linux/ptrace.h             | 4 ++++
  mm/memory.c                        | 4 ++--

instead.

                  Linus

