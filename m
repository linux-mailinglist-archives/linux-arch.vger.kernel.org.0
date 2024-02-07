Return-Path: <linux-arch+bounces-2115-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9B284D237
	for <lists+linux-arch@lfdr.de>; Wed,  7 Feb 2024 20:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2C671F25EAA
	for <lists+linux-arch@lfdr.de>; Wed,  7 Feb 2024 19:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143AC22065;
	Wed,  7 Feb 2024 19:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="TViiTtzA"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A3B8595B
	for <linux-arch@vger.kernel.org>; Wed,  7 Feb 2024 19:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707334052; cv=none; b=m94U+EM3G9FlUOdH/zVenmxbgnBz8ebB3m0FMBteQKaFqyajoqVKqau2lBOh+G8HxH+uzpcxhoGfEQOB3XEO82m92qpCZthNiZya9sESvCr3eG825OdrS5H5zWtWmBRDbMySbz4qgoWpZWEB+MkJin5FmTwaVmZPJxUJ8LzUFAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707334052; c=relaxed/simple;
	bh=5RaTiIWx9wDoTYXHqrYH6XJ/pBQOCNuol350peNdprY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=U1L2QnGM7y8eo02S87eZr8c9rAZWJL2GOso6J0oJVDbmBRDAgMkmmkXVgcAPlH35q2S2RL9JwojzEnw2472P8W1e4O2WKTk9ldhK3emDjrv9k34UV3CuGz2fiUmYKgfP2nLFCAAHbLipNNKZpX3vBdFEUQL0hjIxCx8O2OEKknQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=TViiTtzA; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-42c1eb66355so8847351cf.2
        for <linux-arch@vger.kernel.org>; Wed, 07 Feb 2024 11:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1707334049; x=1707938849; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cA5YwgvtHoLDpmj5Skshopyo0pdeDCfKH8nml3v6ZvA=;
        b=TViiTtzAyVaIrBaq1lcHsQ9AJv+rg/QUQ2fWILE5q56VkvV031ahfyj5KnoaVPxJG+
         M9uGLQupOz0998OezZIktk5NhRzyAnpu9ZcNTAYMYfAC8gKVJwip/oVdla2emp/ZhMUh
         nAtBLA2LcdQhWqxmYup0qP9CTO6RXPUW1ddqp5ajgGpb63swHKoHrjJvDMtBgf6EMCya
         u7aablLGhtysxqqoZjk9gViO6SYPnWcjOAdPwOIZNrztfy7lyUtfjmmvm3pN5mipDCVT
         RszNM3mo1ctob7nLsAtBKFRzHF5OZEY0TwjtvKPumh+yXebsFW3N9u0M2lxkh+WM/LPe
         85Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707334049; x=1707938849;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cA5YwgvtHoLDpmj5Skshopyo0pdeDCfKH8nml3v6ZvA=;
        b=V0GLDUn5XCDLjGxWWEAFeRTIU2x4DwCqVhq3k1qocN9PZcaMRiP1jSQhQhnwGYlX0m
         KZ/mHFuem2SfiW6ei7e7O9FGHAVl9KoLGwEeEHLiKb6CMwyi9dIWWdVmQ2GpuYNVTgRc
         VQ/VgnK4AXTMM+/nUoEUnx+WvCa9UNiUS7TntlWuxUKvRb3I3mug6qgbcKVVQCxxJrfj
         LJdzPx8XhH5fd8eWFNYcENpuhtscoWpGQKmXFYcC0MSt2bgOnlntamVxkfWEUUrWnmwZ
         WWAE2ZMhLuRzJvjEV7vMkLWM7OzjuI+wd4L+kO7HVOEcDMFHmKSnXBFIIA2sDrASc23n
         +fSQ==
X-Gm-Message-State: AOJu0Yz7Xl+68kWSmzSSFX/uHmf5/eOSAnBVJE5M2WUgmeBzVskc/tOH
	m0Do8uvRhlcM00pn9ke8yjK7x5e40kQxP9AO4tFHNiN2Bd/pAZlrRxUpWlMrxk8=
X-Google-Smtp-Source: AGHT+IHsK4ELyrPXdU4ZLmwitvFRj7LYEHNgAJuvSyMPNB8sou2DqRMM7N8MJoYaGqi2rQYT+Fxtqg==
X-Received: by 2002:a05:6214:27cb:b0:68c:67aa:c056 with SMTP id ge11-20020a05621427cb00b0068c67aac056mr6941805qvb.39.1707334049232;
        Wed, 07 Feb 2024 11:27:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXj1ff2e/sYSGxK1YlhNSpJ8/w8GhjTI5LhuvxizKy6x8W/6hos9diJ1ETtTEcLg/TVYmqAIwhTEKHzeaxM9l9DDMoT6Rl/ykv8I5MEn2RQ4RzDTpjnVLYW3ZXn/TNw0ueiAHScDsmwL3AwcGQDqrxvYNXsvFkP1puPtlXLOAxSFw+g/0BCBhy9I8Gajfei3p+mqqln7VJ2vILpUpfwVUdbkVf1werhIL4Xk9hkFoyQSXVpRi34UW/O8UHpavC+10PZ4+KSLIrP8EsbFRi/xpmZIjPE/QII7mdA+9jGp3ZJw+/NwygGxNW2xdpBgA2x1B/FviTu6abT91l6SLSW4ExTkADsYTqPkirRqI14FN4vBik5b9VpObUbi0iUqNRUfVaRBoEsg3TQ3KU+IyoV/60EkdsKc6zC+dDKPwAsDoMmpJz3Nv45Y33ntLQctzsHs9XF3FZuVV8dMiaEtw==
Received: from [100.64.0.1] ([170.85.8.192])
        by smtp.gmail.com with ESMTPSA id nd10-20020a056214420a00b006819aeb62d6sm868412qvb.136.2024.02.07.11.27.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 11:27:28 -0800 (PST)
Message-ID: <b4e20286-eb80-4dce-8d37-0d079ba5296a@sifive.com>
Date: Wed, 7 Feb 2024 13:27:27 -0600
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -fixes] riscv: Flush the tlb when a page directory is
 freed
Content-Language: en-US
To: Alexandre Ghiti <alexghiti@rivosinc.com>
References: <20240128120405.25876-1-alexghiti@rivosinc.com>
From: Samuel Holland <samuel.holland@sifive.com>
Cc: Will Deacon <will@kernel.org>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Andrew Jones <ajones@ventanamicro.com>, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240128120405.25876-1-alexghiti@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-01-28 6:04 AM, Alexandre Ghiti wrote:
> The riscv privileged specification mandates to flush the TLB whenever a
> page directory is modified, so add that to tlb_flush().
> 
> Fixes: c5e9b2c2ae82 ("riscv: Improve tlb_flush()")
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/include/asm/tlb.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
Tested-by: Samuel Holland <samuel.holland@sifive.com>


