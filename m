Return-Path: <linux-arch+bounces-4370-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FAD8C4621
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 19:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8AED1C22CE6
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 17:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5390F28E34;
	Mon, 13 May 2024 17:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="BCXLY9ht"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3235249FE
	for <linux-arch@vger.kernel.org>; Mon, 13 May 2024 17:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715621622; cv=none; b=gIEasvBXjz1cINZUbF9cn4t6s1Axctxlj81PceQRCZRfptaiJTiNNfVa/Z7liguTfZyOYLl8EpbzqLpVYgot7qUPtKBhlQmEBx0pNSHnsIzuwsOOGeD955qn46sUHsVtIyzeqioD+s6J3OrQd6+mI6hVKgnouUd4FzuncEDXszk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715621622; c=relaxed/simple;
	bh=5faudNSwXM6eDrDOP7g8vTHfKZ2ssptQWyhi+r9NbAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gCd5QxXQT8iKlMP/mr1LU7ifjnsNF5dvrHbtO1tVKvtpj0rszo+8Uav1dBj61fpOL3Oqbe4IO79SE4F3nbFA7l+88A8Aa/d0qO6aNyNslVsMmyjs3dZjKkMorYgohlhFRLKMVZDZlY7b3jv20nJkGWQSJC/gx/QzwIbIu4pzuz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=BCXLY9ht; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5d8b887bb0cso3838747a12.2
        for <linux-arch@vger.kernel.org>; Mon, 13 May 2024 10:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715621620; x=1716226420; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pNmfAcSQRV/kelva/h+PHsNWBp57DY+kk0TmAOrYUcA=;
        b=BCXLY9htU64FtOhStHOPwzH3nxFYlucGGiYf+eUeT5lEb+lMWHo7Nj36oEVzyOMrom
         JRSAHZ6yfLyqPf606RytRsKxx8IZL3EeL6FNbHrRqwRinzpMZnUpzzmJQk5EGV4xsH0f
         SaGEBFWgRtkgFQMoUXWMxA980zbQOTugr0iNTuQIbWUebF9gd2h49YWRBxNOZbDM+CEZ
         j6XRfMgQ6N0UebecqLh9Vf3nB7f11M+UjHiCOuSiau2T8HxH4+B0bqayV41kGI6QZLCT
         QNhLwhR9yDghQODmN/E5aYls+5N6/dNygBXTgYFo8g4FLRwJ1728RwF72reTu8jFKzzK
         TsjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715621620; x=1716226420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pNmfAcSQRV/kelva/h+PHsNWBp57DY+kk0TmAOrYUcA=;
        b=qQYmMfab96ej3Nwf8KuuvGUbpwyJS1a9KmKDt5n1Y7ajQYfXM4WJQJFzNX8lZwo11f
         2oQ6a3GUZP4gjM9LzxPJAXcUUdW0GGQhK/1OCC01sjY1MV39Fp0NkWN6iuw2vAOT8EPe
         6nJjiFWYchFalaTmlK8qI8e0TIzYyHZZTRpAgmfy9iJtP4u1kOUtC34DxpqRSkwxddrM
         V9mE/Nmn5YYE6Kanzd8VvewJU6qGPmpbwNe0eC+umizN6brwU5HcWEiCbtcYdpYoX6dl
         EUbQTBQIiDpdIKIyJ8YQC1G2lIIpNynT5gapnIBzhnQZ5WG4sdIAROb+jPLz0uZoLXGX
         oHSw==
X-Forwarded-Encrypted: i=1; AJvYcCVPzLSrL6pkSqlruRqN/mpRHI8WI4/F9hyC6oADCn4JTfLcC7RzvQeAa0bytJGpHipk67Wtx3GlH6EJSLrGpe0qWcsDDhPDHO3f1w==
X-Gm-Message-State: AOJu0YxrF/EI4CuHSeuZLZmPM2Mt5uJ1OcGf6XQxA5F50FtCNBhAJ1+P
	P7U0FGzisZgV74uECCXePW9D6dLKfI53KE19mI/lobxDMbiP8cJdoQVNIYR0D8E=
X-Google-Smtp-Source: AGHT+IEusspRKWgMqzxIHo3LjzZ32dPe15H5hiGbuRyTZXAqW+i0ka0qC7uUI7zx+K2rXL0puSVXpQ==
X-Received: by 2002:a17:902:6b44:b0:1e2:81c1:b35e with SMTP id d9443c01a7336-1ef43f4e417mr123656285ad.54.1715621620059;
        Mon, 13 May 2024 10:33:40 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d4733sm81989285ad.54.2024.05.13.10.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 10:33:39 -0700 (PDT)
Date: Mon, 13 May 2024 10:33:34 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: paul.walmsley@sifive.com, rick.p.edgecombe@intel.com,
	broonie@kernel.org, Szabolcs.Nagy@arm.com, kito.cheng@sifive.com,
	keescook@chromium.org, ajones@ventanamicro.com,
	conor.dooley@microchip.com, cleger@rivosinc.com,
	atishp@atishpatra.org, bjorn@rivosinc.com, alexghiti@rivosinc.com,
	samuel.holland@sifive.com, conor@kernel.org,
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-mm@kvack.org, linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org, corbet@lwn.net, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, oleg@redhat.com,
	akpm@linux-foundation.org, arnd@arndb.de, ebiederm@xmission.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, lstoakes@gmail.com,
	shuah@kernel.org, brauner@kernel.org, andy.chiu@sifive.com,
	jerry.shih@sifive.com, hankuan.chen@sifive.com,
	greentime.hu@sifive.com, evan@rivosinc.com, xiao.w.wang@intel.com,
	charlie@rivosinc.com, apatel@ventanamicro.com,
	mchitale@ventanamicro.com, dbarboza@ventanamicro.com,
	sameo@rivosinc.com, shikemeng@huaweicloud.com, willy@infradead.org,
	vincent.chen@sifive.com, guoren@kernel.org, samitolvanen@google.com,
	songshuaishuai@tinylab.org, gerg@kernel.org, heiko@sntech.de,
	bhe@redhat.com, jeeheng.sia@starfivetech.com, cyy@cyyself.name,
	maskray@google.com, ancientmodern4@gmail.com,
	mathis.salmen@matsal.de, cuiyunhui@bytedance.com,
	bgray@linux.ibm.com, mpe@ellerman.id.au, baruch@tkos.co.il,
	alx@kernel.org, david@redhat.com, catalin.marinas@arm.com,
	revest@chromium.org, josh@joshtriplett.org, shr@devkernel.io,
	deller@gmx.de, omosnace@redhat.com, ojeda@kernel.org,
	jhubbard@nvidia.com
Subject: Re: [PATCH v3 12/29] riscv mmu: teach pte_mkwrite to manufacture
 shadow stack PTEs
Message-ID: <ZkJO7mlAYqVwDYt6@debug.ba.rivosinc.com>
References: <20240403234054.2020347-1-debug@rivosinc.com>
 <20240403234054.2020347-13-debug@rivosinc.com>
 <a8ee97ee-c51c-4d6a-a9fc-54b065215ebf@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <a8ee97ee-c51c-4d6a-a9fc-54b065215ebf@ghiti.fr>

On Sun, May 12, 2024 at 06:28:59PM +0200, Alexandre Ghiti wrote:
>
>On 04/04/2024 01:35, Deepak Gupta wrote:
>>pte_mkwrite creates PTEs with WRITE encodings for underlying arch.
>>Underlying arch can have two types of writeable mappings. One that can be
>>written using regular store instructions. Another one that can only be
>>written using specialized store instructions (like shadow stack stores).
>>pte_mkwrite can select write PTE encoding based on VMA range (i.e.
>>VM_SHADOW_STACK)
>>
>>Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>>---
>>  arch/riscv/include/asm/pgtable.h |  7 +++++++
>>  arch/riscv/mm/pgtable.c          | 21 +++++++++++++++++++++
>>  2 files changed, 28 insertions(+)
>>
>>diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
>>index 6362407f1e83..9b837239d3e8 100644
>>--- a/arch/riscv/include/asm/pgtable.h
>>+++ b/arch/riscv/include/asm/pgtable.h
>>@@ -403,6 +403,10 @@ static inline pte_t pte_wrprotect(pte_t pte)
>>  /* static inline pte_t pte_mkread(pte_t pte) */
>>+struct vm_area_struct;
>>+pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma);
>>+#define pte_mkwrite pte_mkwrite
>>+
>>  static inline pte_t pte_mkwrite_novma(pte_t pte)
>>  {
>>  	return __pte(pte_val(pte) | _PAGE_WRITE);
>>@@ -694,6 +698,9 @@ static inline pmd_t pmd_mkyoung(pmd_t pmd)
>>  	return pte_pmd(pte_mkyoung(pmd_pte(pmd)));
>>  }
>>+pmd_t pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma);
>>+#define pmd_mkwrite pmd_mkwrite
>>+
>>  static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
>>  {
>>  	return pte_pmd(pte_mkwrite_novma(pmd_pte(pmd)));
>>diff --git a/arch/riscv/mm/pgtable.c b/arch/riscv/mm/pgtable.c
>>index ef887efcb679..c84ae2e0424d 100644
>>--- a/arch/riscv/mm/pgtable.c
>>+++ b/arch/riscv/mm/pgtable.c
>>@@ -142,3 +142,24 @@ pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
>>  	return pmd;
>>  }
>>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>>+
>>+pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma)
>>+{
>>+	if (vma_is_shadow_stack(vma->vm_flags))
>>+		return pte_mkwrite_shstk(pte);
>>+
>>+	pte = pte_mkwrite_novma(pte);
>
>
>I would directly return pte_mkwrite_novma(pte) instead of assigning pte.

noted.

>
>
>>+
>>+	return pte;
>>+}
>>+
>>+pmd_t pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
>>+{
>>+	if (vma_is_shadow_stack(vma->vm_flags))
>>+		return pmd_mkwrite_shstk(pmd);
>>+
>>+	pmd = pmd_mkwrite_novma(pmd);
>
>
>Ditto here.

noted here too.

>
>
>>+
>>+	return pmd;
>>+}
>>+
>
>
>Otherwise:
>
>Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>
>Thanks,
>
>Alex
>

