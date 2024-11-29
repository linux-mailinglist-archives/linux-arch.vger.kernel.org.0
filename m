Return-Path: <linux-arch+bounces-9192-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 080119DE9E6
	for <lists+linux-arch@lfdr.de>; Fri, 29 Nov 2024 16:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD3C7280EA0
	for <lists+linux-arch@lfdr.de>; Fri, 29 Nov 2024 15:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A438313D276;
	Fri, 29 Nov 2024 15:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEHGxX1l"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC8928691;
	Fri, 29 Nov 2024 15:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732895129; cv=none; b=sAH5vdjphZiRFJef7IypXVf3FkJkuBrjLgJdR7PnX4JbXjKxi+5nMBww5CanRq7KilkoxBa2egxIGakLIv3jNurCNEhaOduj/NAX8bhqg9cTaKJOwV9/knxw9r6PRi1yEy6IAyggZjH89vSuLV/6maiML+b8topLWt4WAZmp0b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732895129; c=relaxed/simple;
	bh=T+s3ECWtjs/j1FbkzpUGtX8xs/bOkRYQuQ4Qy6OR5/o=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=RNtM4ExKSJ+w0+lkCLRreV0SELc3iMvDj5m8QJjs8QogGiZg7bR8gNSZ0B0QVn9hT0I4iGwRZGh1P4qn806zYVcDh3IdxRdoWlyK7OGH3owG/mPwl+wTeKkk1SV0Ku/cjgiEbkeuMJr0ypykUoo5MiAUAXCA76CMyPaC42ct+nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eEHGxX1l; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ffb0bbe9c8so24526421fa.0;
        Fri, 29 Nov 2024 07:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732895125; x=1733499925; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i4Y/6YsRynhUQI3gi/feAQN5R86FvfIbQOixX2P5uMg=;
        b=eEHGxX1l3ms3c51tGqbR4thZPG4MexSuC7cdnZN7iMZ1gHcdz7QwmG47B1Fxvv++fU
         7SBjKHaD0hFV8DXzne54Nqrvdcyc/epE30ecUJreLNQDxI/gkCJVQIDoLOLSSNH+Wmx6
         PY+l9ylJqbWwpxrTBmw1gU3ZP5hTs+QMHqo71Kp6YrIHUQ3j9EPAx8NvXK+7MjD3l+G8
         wVk+eW7uVCN5G9AkvFajMlv+rfJrSaeyjZdrtKLCUNG5tcwqkwyQUt+lwWyEEjyx6gwB
         SawGTm7aNrmgo6Yg1yqhNBYEKUWfHOgpIQDeHOYP0LT+prboMXZMjfmHngZ/Ma4lgEiv
         r0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732895125; x=1733499925;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i4Y/6YsRynhUQI3gi/feAQN5R86FvfIbQOixX2P5uMg=;
        b=a5NyqS6EnwD8LP+XG5ytoczp+SJ/1fWcdvSeQoMfyp7yaAYRfAUJw+7ew6Ip24wiEr
         FXdzNEpM1eqpN9l11Uucy5hP5Gph8qPyalyul9i+vknhkHrvAflOjud2qOe1OaN3avUF
         x7ZPR8L3l6kvtJ2GcjbG4UGuzTKkhuoUB+SeMQJjf+lG2hnPUR2r8QmnR3wpnN7tr0Tx
         pTEet/VGVUJvMSPQgQjHu1Bow8OLqiHp72YTut1uwisjQlmVvmsmwecBxznJw+mJJ0Tx
         u0pG+10pqNempNw4/ELwWXaGONSA+Xkdrlbn6DyoHUZhrCxllnqNiaFas0yIm8iQmBlb
         55Lw==
X-Forwarded-Encrypted: i=1; AJvYcCVAAJgRyaVe5XODJorybIFfk6/9q1KHiLEE1EO7ybUnqVfIr1AoBA+IYxCDwVwcM9Bc6KA39okL956I@vger.kernel.org, AJvYcCViskq1YzqDoTp4DNvO3nz3gWnfz3P1GpznbguCtH8twbFveB1clTfLqVAl70S44dK1OI+o3cBr@vger.kernel.org, AJvYcCWIrDTO5woAKf9wLfiAY+Lu1QQWP0OPzxSae6OcjQVKcSaBVfvBsM1eCMIRah+rxpborRXyVwRKLaMDDCzU@vger.kernel.org, AJvYcCWLtMQRXiSt6xq7V06SLm9McEkMXwvJGFGLDvWUrfAB0HslUE//5FdXY7rJre6asyFaIpYMghb3GW6RTjGg2pk=@vger.kernel.org, AJvYcCXgf9zR9V13gdwoQhzCV0Ff5eV/CPkLtNR8yzBAAbvk7eqLodCws7HcMsAWAU/l1S4xV3oyk+/i8ua7te2s@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu8IDZnPtgAVyXJd1o8L7rXeE+24W42rlW8FRKSoWd7nEcYA4a
	AuaHeV2/+1OiLe/yZj4VXH3C3Kz2kwPaWPan8E8tmPLuIVbwz13z
X-Gm-Gg: ASbGncvXoaQSDKq7SRxgr5ZgfJ3d8Xwh732NfQohK9R23QDiLOqIi6FT8dNol+StJNi
	bbZDvhyVQthvYxB/HV51MG7F1MYi3j2O9ldzEJ/LuAVx2Z1nwh4NWkZDFk7qN4mTL5ZNaj318jn
	a/HoECTqH6JQ/zmhf3Wns/firZKKTqIAP1QC2bePPfq5tKkuGhB/N+HfxuKZ+m/VjSbjTHqghyq
	nHHjCSR56ur+qd1I5GeWNY0sY4nKsm8ERA2B9Q5Naj2YkeC6u5fC3S52vP4fWvl5Sw=
X-Google-Smtp-Source: AGHT+IGdf09ewurCXHG4aOkkaYVMwJ5lfvxLKfHbX3YBVf0cJU8E7jTdYjT8obhGs9IkbVrmTkJl6A==
X-Received: by 2002:a2e:be0d:0:b0:2ff:ce6d:8433 with SMTP id 38308e7fff4ca-2ffd604a03amr86985111fa.8.1732895124540;
        Fri, 29 Nov 2024 07:45:24 -0800 (PST)
Received: from smtpclient.apple ([132.69.243.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d0ae0cfc3asm992257a12.18.2024.11.29.07.45.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Nov 2024 07:45:23 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [PATCH 6/6] percpu/x86: Enable strict percpu checks via named AS
 qualifiers
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20241126172332.112212-7-ubizjak@gmail.com>
Date: Fri, 29 Nov 2024 17:45:09 +0200
Cc: the arch/x86 maintainers <x86@kernel.org>,
 linux-sparse@vger.kernel.org,
 "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-bcachefs@vger.kernel.org,
 linux-arch@vger.kernel.org,
 netdev@vger.kernel.org,
 Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>,
 Christoph Lameter <cl@linux.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@kernel.org>,
 Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andy Lutomirski <luto@kernel.org>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 Brian Gerst <brgerst@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>
Content-Transfer-Encoding: 7bit
Message-Id: <9CECB9F7-E700-4A92-98B9-6FD027F9CE65@gmail.com>
References: <20241126172332.112212-1-ubizjak@gmail.com>
 <20241126172332.112212-7-ubizjak@gmail.com>
To: Uros Bizjak <ubizjak@gmail.com>
X-Mailer: Apple Mail (2.3826.200.121)


> On 26 Nov 2024, at 19:21, Uros Bizjak <ubizjak@gmail.com> wrote:
> 
> This patch declares percpu variables in __seg_gs/__seg_fs named AS
> and keeps them named AS qualified until they are dereferenced with
> percpu accessor. This approach enables various compiler check
> for cross-namespace variable assignments.

[snip]

> @@ -95,9 +95,19 @@
> 
> #endif /* CONFIG_SMP */
> 
> -#define __my_cpu_type(var) typeof(var) __percpu_seg_override
> -#define __my_cpu_ptr(ptr) (__my_cpu_type(*(ptr))*)(__force uintptr_t)(ptr)
> -#define __my_cpu_var(var) (*__my_cpu_ptr(&(var)))
> +#if defined(CONFIG_USE_X86_SEG_SUPPORT) && \
> +    defined(CONFIG_CC_HAS_TYPEOF_UNQUAL) && !defined(__CHECKER__)

Is the __CHECKER__ check because of sparse, as in patch 2/6 ?
If so, do you want to add a similar comment here?

Other than that, I went over the different patches and it looks good as
much as I can tell.

If it means anything, you have for the series

Acked-by: Nadav Amit <nadav.amit@gmail.com <mailto:nadav.amit@gmail.com>>

