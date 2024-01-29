Return-Path: <linux-arch+bounces-1743-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7D583FC96
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 04:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B17562822FF
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 03:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF7DFC12;
	Mon, 29 Jan 2024 03:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Y697E+sw"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D06FFBE9
	for <linux-arch@vger.kernel.org>; Mon, 29 Jan 2024 03:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706497631; cv=none; b=R2z34QPIAsfWFwdBMcSV1ELw4CjQH+cv9Eu2C1wrJdVOXge3g8NWIxGdoCGufH9fVz58gUWmvECfJoIFsEPkRq1JPIACj1BhDu4n3yYwUQT8QJ+g4toaVOdvC52YG4B7z+m1Z5gbXRiWo1IGy1FFu0UNhWs/EoZe9R23P/Zv1zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706497631; c=relaxed/simple;
	bh=7tR76fG0CtwOXKVJW2uJ4Evju11jpczw9YfBchqS8q8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GlU4SyrbTqOY4O7e7e0CTMBkR0CjizYT+XSgLeOOm+dUbuYIaX2yYwaIYpCfCjfUugByU4o6Zj5CjTqSavuG/N21cLch4TeCE53JG5lyoYD/T3mRsuvgG6nXB3Rq1nna8wEYqCcCd7GN87ON9blexWVdF84tdikGwOi0Z+uXs6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Y697E+sw; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6e0f43074edso1193744a34.1
        for <linux-arch@vger.kernel.org>; Sun, 28 Jan 2024 19:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1706497627; x=1707102427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5VmEsB3BrVhcksANfHb/8QboZcv6m1DkmrrBxCJMlos=;
        b=Y697E+swwpbTKD1pk9AwE0rEHdpXL2VPmkNtheebgqvjyFbwj/+N69Mr25CfKSutdj
         dajG9OKN7KIVq1o1ENO52dLMyZfKCw8qXZ3jQnogB+YHnkGR0xN+ZRdwM3YFe7TFrV51
         R6FI7WnCsWefO49j6xEwBlHrQB6NgkVY/3NdKm3pLoreJEZL8Qo5sUFcbWHD4WpyOX9u
         SinlZ8weZVEOpuabbfOWDMjkp3KUja2mw0zsfq4ki2x6KnNePplQPbnB347vPYCkIudH
         G5x8/JFI4B0louE8oJPHNJLNCN3Ts2Vo0xMAuTQTPr3CQQ7Rwjnoj2PYlXuAiU4N84aR
         2cPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706497627; x=1707102427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5VmEsB3BrVhcksANfHb/8QboZcv6m1DkmrrBxCJMlos=;
        b=w+87m72BpxYAOnX1NYMJ8e3j4Y+iP0DQ/NiysoDa8jmP7MLVzxsrQls7/b/TM5p7gb
         8bnLf22UH7NY4SEomc0s2O6OA+ilL7LxLIApFhtw2mZKkzXmW8XrS9D4zgo9nxbJhjUW
         uUoSqVQ8xmGiZOuFlfRmrE9cw3b+o2/88BS/pLyt4wySqYgmmidQPBmP2dsuNoUQocyE
         Vwc3op18h+V+tuIBN3AplhpK6YF5wjiyAU3MbGPod7RvG/4v2okyTN4ZxY3w7YFiwdHZ
         taPogowjDivRJDtdbeXvASc7uBh51j5pGDEExRLyfBr8FhyRQ3+WcPZYnHifty/fS+XR
         VidA==
X-Gm-Message-State: AOJu0YzkWdPF9ZuVkZEWNG6QOSN7SN9v2hJlreJ4CQEfgUE/R01ny789
	LrAfClD28Ag4AkEqT+gYxW46MiypSLXdN5GpcNtvzB6nP5SrGe2vIodhHF8pWjJI9pDRK6/sxb5
	Ek20Kj4uiJ/vWjOMdcJnVhm8edUtxjoJaE6oX8Q==
X-Google-Smtp-Source: AGHT+IEWlpSCuURK2908qpVhjPZ38PveXtCpdAx9PaagZ0ywJkZb7DWA1aHVXgttgRYK55tCSUygd093guftonqGw1g=
X-Received: by 2002:a05:6870:b401:b0:214:fc3f:3471 with SMTP id
 x1-20020a056870b40100b00214fc3f3471mr1192447oap.40.1706497627335; Sun, 28 Jan
 2024 19:07:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240128120405.25876-1-alexghiti@rivosinc.com>
In-Reply-To: <20240128120405.25876-1-alexghiti@rivosinc.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Mon, 29 Jan 2024 11:06:56 +0800
Message-ID: <CAEEQ3wmXvnqdvv39JZhkfUsoLbJr4B2WwdgWnGY=aHgE8A-+0g@mail.gmail.com>
Subject: Re: [External] [PATCH -fixes] riscv: Flush the tlb when a page
 directory is freed
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Will Deacon <will@kernel.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Samuel Holland <samuel.holland@sifive.com>, Andrew Jones <ajones@ventanamicro.com>, 
	linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexandre,

On Sun, Jan 28, 2024 at 8:04=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> The riscv privileged specification mandates to flush the TLB whenever a
> page directory is modified, so add that to tlb_flush().
>
> Fixes: c5e9b2c2ae82 ("riscv: Improve tlb_flush()")
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/include/asm/tlb.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/tlb.h b/arch/riscv/include/asm/tlb.h
> index 1eb5682b2af6..50b63b5c15bd 100644
> --- a/arch/riscv/include/asm/tlb.h
> +++ b/arch/riscv/include/asm/tlb.h
> @@ -16,7 +16,7 @@ static void tlb_flush(struct mmu_gather *tlb);
>  static inline void tlb_flush(struct mmu_gather *tlb)
>  {
>  #ifdef CONFIG_MMU
> -       if (tlb->fullmm || tlb->need_flush_all)
> +       if (tlb->fullmm || tlb->need_flush_all || tlb->freed_tables)
>                 flush_tlb_mm(tlb->mm);

Why is it necessary to flush all TLB entries of the process?

Thanks,
Yunhui

