Return-Path: <linux-arch+bounces-15700-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8C1D00AC6
	for <lists+linux-arch@lfdr.de>; Thu, 08 Jan 2026 03:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D0913065DE9
	for <lists+linux-arch@lfdr.de>; Thu,  8 Jan 2026 02:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B5023EA99;
	Thu,  8 Jan 2026 02:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGb3dmaD"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1063923D7FD
	for <linux-arch@vger.kernel.org>; Thu,  8 Jan 2026 02:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767839033; cv=none; b=DeLLf3e/B1Vt9BQHhXcfo7IrCY7fgklFNosskHx+2VYC3BXKdUE3l5EmSQRXKyyCxoeMPU2IOCkqQ464OKpw+U3psU+jqQvJ5BVmukbwGaf0RhhyEUQGeY1DoxfSNgknQmY0q1j6SNlLapEcxHvcc15ejUZduHjwE4DTVgmJBGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767839033; c=relaxed/simple;
	bh=ZDpPQWr5z3NT2bQ1AQqz7QtzavFPv5XMuiJ4qVKOIms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IT53UAkba+IuF8WEcEnk3dA6MphWPqaYV+LyNczQZPJnb68WE724xd5QabMge/Zp1ExbfXko3UdEJ5fVGeoucu4JfSrApHqgTlwMP7PXF9aHtxXg0+B/IuS5wSjAjhwsI9FpJfIQrEKckfWVB1rWshrN1X3Lec9iG8fHBHqDidk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MGb3dmaD; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-78c66bdf675so27815637b3.2
        for <linux-arch@vger.kernel.org>; Wed, 07 Jan 2026 18:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767839029; x=1768443829; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6WPMqEgbiq/1nCGoqJgHIPGVbxZP1MvEMarO5Hdi07w=;
        b=MGb3dmaDQKsX//2UaMn18UEyPEVVOrwpxvgc2plAE81AZgWHrrAgPjTatOAPslaTB5
         EfQ5rgoTupA4yNHOh7kI082eN62vYdquEf+7Cxn9HonhYZ2JfJOVkG+0GqmUlWz4+R0q
         NShQVulSEA7CR8bEiX2zr4wBM4g55McgeeGcJbmFP+GlF3NxbnNvA0pz9vdS54zmM5ZY
         fP2HHaeUXBjYV20GVogADu5n3l11A34uA+a+JZUmfBKNg9s7AtPxn875jkeRmjVgxqWl
         4QO129EL8ru8/vAukdfLmGvUSTHOsynYrp8RzC4QWYZwB5sFp2xWTbnboRzQofpJDx8p
         cWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767839029; x=1768443829;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6WPMqEgbiq/1nCGoqJgHIPGVbxZP1MvEMarO5Hdi07w=;
        b=dmxT7B9qct99H0MGKBcA+XYT+yrxDtKsHj1oPu0JnrL6GDzXsB9w9iXnL5EKcR9VmL
         uBeCr/aKKW9KZtpmDC3Ez9JYx0S7MOvSSsR89y/V4Z3pSj/ieF2bNVQEc6xcn3Yf/B4D
         IdPoAi+cRagJLMhKzqEpBUHLmoYRW6iIZfx6zXc2KHqAV0BBd1O07YJAgZOc855rx1vC
         Jf7xLdcK971YaCQt2mLtWcaQUguiRthkbl7Hz7O1/sWLzWbsp4PoGMAyOlUjbCqetC/f
         Zzus/oU13h4H0df/FCJhQY1EeUNMVXr3z+sDPDS9aXSwTrBEMHqtJ2Pr6qJIwdIYGPEq
         AvaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXW/FH5wO69+/7Hs+0YVLZL79VGoVU7JFCnnmITGXRuROkajM1HebP1YZq69kgsL7d06r6sJ+LvhymG@vger.kernel.org
X-Gm-Message-State: AOJu0YxfkTLA3PRr4hVWwL0qpQ7/PLl7/f3yBx9kgFuP/S7yWS4bPNg9
	ol1AezbQ3hl41F4e+5m5CQdgkT5j5k0kfzwNgmZofO0t1RbM8Sbs2KJl
X-Gm-Gg: AY/fxX5IKYd4HGRGM39ryYQfz1O831VqqFTpQTDG5MQyWXB1L3YGGrk1oSTkrtAmZIw
	uToEMG1A1BP90Q/ZEwGueL7Czq7W6tq5me7LXEvFp90hmZmxNx/8JG2NmSMaaC4k/2HPu1LWDuo
	OYt2KGHmSid45DgQOj8oJ0BKv01asUq89RHa87MOUpB3hoaF/DAxmqTqRR35LXoxt4CUtLhfVBb
	fQnLEU0u3akBVJVytaEFOzWCKTnYLQD5/1pkyQCw0cVL0Qf6FrPi3hAhjZMgEVFfdWuyfVGhVKA
	Nqrdl8u46IaajDF4RKIUenIOzJruAgzyH+gOGk+9SGK//dtRCcBowp4YmK3VPtOJX2XVpUV2gTg
	GmQJPq/z1m++OL4Kcd2xRyQb6OWyisstbO/Oy/IyZzKpyeXwa32LtaNoeeVvUoqaLmqql6EpIM2
	w3NhEZYwdvJeCXi6OXbjnGVh9gmDJIPU5tQznixg==
X-Google-Smtp-Source: AGHT+IGgMpL+kZMdvF4ADTgetvjR8KjnRPwe3Xe2CKlVvJLk69qHA2NQZ4MxPPVQYhnVGWyKjWzQjw==
X-Received: by 2002:a05:690e:1c06:b0:644:6b68:f126 with SMTP id 956f58d0204a3-64716cacb29mr3927712d50.77.1767839028925;
        Wed, 07 Jan 2026 18:23:48 -0800 (PST)
Received: from [192.168.2.226] (104.194.78.75.16clouds.com. [104.194.78.75])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790ae603282sm21321087b3.13.2026.01.07.18.23.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 18:23:48 -0800 (PST)
Message-ID: <1d110134-89ab-474b-bca6-cfbfd4b5057f@gmail.com>
Date: Thu, 8 Jan 2026 10:23:19 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/pgtable: convert pgtable_t to ptdesc pointer
To: Matthew Wilcox <willy@infradead.org>
Cc: Mike Rapoport <rppt@kernel.org>, alexs@kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>,
 Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>,
 Brian Cain <bcain@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Michal Simek <monstr@monstr.eu>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Stafford Horne <shorne@gmail.com>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>, David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>,
 "open list:ALPHA PORT" <linux-alpha@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:SYNOPSYS ARC ARCHITECTURE" <linux-snps-arc@lists.infradead.org>,
 "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
 "open list:MMU GATHER AND TLB INVALIDATION" <linux-arch@vger.kernel.org>,
 "open list:MMU GATHER AND TLB INVALIDATION" <linux-mm@kvack.org>,
 "open list:C-SKY ARCHITECTURE" <linux-csky@vger.kernel.org>,
 "open list:QUALCOMM HEXAGON ARCHITECTURE" <linux-hexagon@vger.kernel.org>,
 "open list:LOONGARCH" <loongarch@lists.linux.dev>,
 "open list:M68K ARCHITECTURE" <linux-m68k@lists.linux-m68k.org>,
 "open list:MIPS" <linux-mips@vger.kernel.org>,
 "open list:OPENRISC ARCHITECTURE" <linux-openrisc@vger.kernel.org>,
 "open list:PARISC ARCHITECTURE" <linux-parisc@vger.kernel.org>,
 "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
 "open list:SUPERH" <linux-sh@vger.kernel.org>,
 "open list:USER-MODE LINUX (UML)" <linux-um@lists.infradead.org>
References: <20260107064642.15771-1-alexs@kernel.org>
 <aV4h5vQUNXn5cpMY@kernel.org>
 <080e493a-e4f1-4c97-a3e1-f76f126b5213@gmail.com>
 <aV5yIuGi9Ni5YP5E@casper.infradead.org>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <aV5yIuGi9Ni5YP5E@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026/1/7 22:48, Matthew Wilcox wrote:
> On Wed, Jan 07, 2026 at 05:28:36PM +0800, Alex Shi wrote:
>> Right, I will fix this. and sent the 2nd version.
> No, the patch is stupid and wrong.  Don't send a v2.  You seem to have a
> hairtrigger resend, so I'm trying to prevent a v2 being sent instead of
> sending a patient reply.

Hi Matthew,

I hear you—no v2 will be sent.
but sorry for a bit confusing, what's your expected fix? is the too 
quick resenting? or the direction to alignment pgtable_t with ptdesc is 
wrong?

If it's the first. the new change for review address Mike's concern.
diff --git a/arch/arm/include/asm/pgalloc.h b/arch/arm/include/asm/pgalloc.h
index a17f01235c29..a204c3ac800a 100644
--- a/arch/arm/include/asm/pgalloc.h
+++ b/arch/arm/include/asm/pgalloc.h
@@ -94,13 +94,13 @@ pte_alloc_one_kernel(struct mm_struct *mm)
  static inline pgtable_t
  pte_alloc_one(struct mm_struct *mm)
  {
-       struct page *pte;
+       struct ptdesc *pte;

         pte = __pte_alloc_one(mm, GFP_PGTABLE_USER | PGTABLE_HIGHMEM);
         if (!pte)
                 return NULL;
-       if (!PageHighMem(pte))
-               clean_pte_table(page_address(pte));
+       if (!PageHighMem(ptdesc_page(pte)))
+               clean_pte_table(ptdesc_address(pte));
         return pte;
  }

@@ -141,7 +141,7 @@ pmd_populate(struct mm_struct *mm, pmd_t *pmdp, 
pgtable_t ptep)
         else
                 prot = _PAGE_USER_TABLE;

-       __pmd_populate(pmdp, page_to_phys(ptep), prot);
+       __pmd_populate(pmdp, page_to_phys(ptdesc_page(ptep)), prot);
  }

  #endif /* CONFIG_MMU */

