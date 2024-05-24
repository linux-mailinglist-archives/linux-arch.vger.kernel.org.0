Return-Path: <linux-arch+bounces-4512-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 994138CDF46
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2024 03:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 934741C20B15
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2024 01:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654158BF3;
	Fri, 24 May 2024 01:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClGWt75N"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977AA63B8;
	Fri, 24 May 2024 01:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716515221; cv=none; b=P3YMqGP47wrEUTqaa0gSGlAhWuD6O/2HXTC11tBZEqtPBntikQZK3UdG2qKM6gItCHhbC4IVuPuPuRSpUiK/7dbVqpD8LFgQGlJdSkrNqruBqdp/0On7xpGQdY9GpsAntJ9JGSqlXmSErHbgEwxJjPoccaZbsV24bJkM1yfAAOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716515221; c=relaxed/simple;
	bh=iAibcjhB3i077su1Tv38KybDJGy0gFiwnwF9ePlbHgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oee9AWGuHyuiDGgrwUrP6PIiapucJBidT5Nhcw03hAyDznQRLJvsN7CTXq6zg9E9x7JUa8XEiUqc0HBmAyHqcNbejcwDAtVYLgXNuqCWRlnj6ziMVkOeCv1Biyhv5gMwDTGZqFSTaynO50hluwcVb/tpsIt8USl03AuGCD3vgcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ClGWt75N; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-354b722fe81so2599361f8f.3;
        Thu, 23 May 2024 18:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716515218; x=1717120018; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6jwG8DKwa2D68PCR9THchOvJn/p8bGOM0gVPOEmuF4=;
        b=ClGWt75NtcpXiFnCYDRx41+l8bNjO+YEwvQe3J/yp0g8im/wkH78ffw4NIg1B8M7RH
         36eoJTXnOXe1zrFAdhvP4Ypfxi8YyZg426jRlXuAmdLz5h9LIOAGC1yFIdJhPVKkAgsD
         okQFIWwkwzC12v/nelAvHtr9HlBTvFIdbsjcwlE5jzDWy4paFoDhTgPpf8FjNH4XbyWr
         QATi9Ekq4ASkn75dWtu9Q8dImufhso8pAqQv0XjQUEYIOzQEgrSXJ6hohSS4YrVwHnLw
         Zfu4tYKUgv0IN8rPW5v9i26KK0j/tmUf0M3L7BuPRf6mMOzSCYOF4X7JtdgivQUGfL1r
         pl1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716515218; x=1717120018;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t6jwG8DKwa2D68PCR9THchOvJn/p8bGOM0gVPOEmuF4=;
        b=hRxedeQlIsiSUtnDbMNBtnR8EQjlQIUxqt5p8IP6RJkEpUfPSpr6Fm5wM8/04NUPLS
         gG2xdjwaEopp1keJuWs07OsZbT4SXAcsYIx4oV8ouyRkf4SdTfzGuT8fDNz6kFkC71wP
         v4MTS6R37aTFd/dPvoG9hlC6AmuEFEQu8SgPGMIhvO9uOzfu48CZLo7IU6GKOUiBvnrZ
         Mzd5hRt+407uceIk9YnTd/nTRsmERlVyjkpKiSr+P8S2qMgKUb4NTNf6JrtoB/OCmdgG
         nUIbOxxL77f+4iGaSMfa8jih5+0qvJ6XjCZgsr1jC6HhXG/8nPFwBxaCvJo4EKRUh8oJ
         ppJQ==
X-Forwarded-Encrypted: i=1; AJvYcCV24VTHMhGxrMtZH314aKZ/0xSTFOcW82m5k3zWJL4i90vrZk6tLvKp3jzOqpJMEeUqXm5JKjAzurwuVT+za/un1jMn707lkWqZGNxAMBuuj4Gm8D9m756XchtYPUDAS2y8zdy8+5DGfw==
X-Gm-Message-State: AOJu0YxdDaouHeEjZniNp3Mi0XWFyV3XL/oh9EmYsMLfmXGK1PgzEQYH
	ESwGBCl4PNS7mjAYuibQFbnlW+eUh0RCU46QAxJmjzgLBr23tfTwHRE+hg==
X-Google-Smtp-Source: AGHT+IHDazZVS98g6jCPWCi6GMzJXJccQeP8EnJhTsM0NPuM+NoCFvUGXOm/kOMvOGJZBv5HNLIsdg==
X-Received: by 2002:adf:ffce:0:b0:354:f802:f3a6 with SMTP id ffacd0b85a97d-355245e31b5mr430730f8f.9.1716515217640;
        Thu, 23 May 2024 18:46:57 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc51ee7sm41771366b.139.2024.05.23.18.46.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2024 18:46:56 -0700 (PDT)
Date: Fri, 24 May 2024 01:46:56 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, mpe@ellerman.id.au,
	npiggin@gmail.com, christophe.leroy@csgroup.eu,
	aneesh.kumar@kernel.org, naveen.n.rao@linux.ibm.com, arnd@arndb.de,
	anshuman.khandual@arm.com, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [Patch v2] mm/memblock: discard .text/.data if
 CONFIG_ARCH_KEEP_MEMBLOCK not set
Message-ID: <20240524014656.odw4yuvhgbu4dgf7@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240510020422.8038-1-richard.weiyang@gmail.com>
 <ZkxLkK7vgzzaEvyw@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkxLkK7vgzzaEvyw@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)

On Tue, May 21, 2024 at 10:21:52AM +0300, Mike Rapoport wrote:
>Hi,
>
>On Fri, May 10, 2024 at 02:04:22AM +0000, Wei Yang wrote:
>> When CONFIG_ARCH_KEEP_MEMBLOCK not set, we expect to discard related
>> code and data. But it doesn't until CONFIG_MEMORY_HOTPLUG not set
>> neither.
>> 
>> This patch puts memblock's .text/.data into its own section, so that it
>> only depends on CONFIG_ARCH_KEEP_MEMBLOCK to discard related code and
>> data.
>> 
>> After this, from the log message in mem_init_print_info(), init size
>> increase from 2420K to 2432K on arch x86.
>> 
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> 
>> ---
>> v2: fix orphan section for powerpc
>> ---
>>  arch/powerpc/kernel/vmlinux.lds.S |  1 +
>>  include/asm-generic/vmlinux.lds.h | 14 +++++++++++++-
>>  include/linux/memblock.h          |  8 ++++----
>>  3 files changed, 18 insertions(+), 5 deletions(-)
>>  
>> +#define __init_memblock        __section(".mbinit.text") __cold notrace \
>> +						  __latent_entropy
>> +#define __initdata_memblock    __section(".mbinit.data")
>> +
>
>The new .mbinit.* sections should be added to scripts/mod/modpost.c
>alongside .meminit.* sections and then I expect modpost to report a bunch
>of section mismatches because many memblock functions are called on memory
>hotplug even on architectures that don't select ARCH_KEEP_MEMBLOCK.
>

I tried to add some code in modpost.c, "make all" looks good.

May I ask how can I trigger the "mismatch" warning?

BTW, if ARCH_KEEP_MEMBLOCK unset, we would discard memblock meta-data. If
hotplug would call memblock function, it would be dangerous?

The additional code I used is like below.

---
 scripts/mod/modpost.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 937294ff164f..c837e2882904 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -777,14 +777,14 @@ static void check_section(const char *modname, struct elf_info *elf,
 
 #define ALL_INIT_DATA_SECTIONS \
 	".init.setup", ".init.rodata", ".meminit.rodata", \
-	".init.data", ".meminit.data"
+	".init.data", ".meminit.data", "mbinit.data"
 
 #define ALL_PCI_INIT_SECTIONS	\
 	".pci_fixup_early", ".pci_fixup_header", ".pci_fixup_final", \
 	".pci_fixup_enable", ".pci_fixup_resume", \
 	".pci_fixup_resume_early", ".pci_fixup_suspend"
 
-#define ALL_XXXINIT_SECTIONS ".meminit.*"
+#define ALL_XXXINIT_SECTIONS ".meminit.*", "mbinit.*"
 
 #define ALL_INIT_SECTIONS INIT_SECTIONS, ALL_XXXINIT_SECTIONS
 #define ALL_EXIT_SECTIONS ".exit.*"
@@ -799,7 +799,7 @@ static void check_section(const char *modname, struct elf_info *elf,
 
 #define INIT_SECTIONS      ".init.*"
 
-#define ALL_TEXT_SECTIONS  ".init.text", ".meminit.text", ".exit.text", \
+#define ALL_TEXT_SECTIONS  ".init.text", ".meminit.text", ".mbinit.text", ".exit.text", \
 		TEXT_SECTIONS, OTHER_TEXT_SECTIONS
 
 enum mismatch {
-- 
2.34.1


>>  #ifndef CONFIG_ARCH_KEEP_MEMBLOCK
>> -#define __init_memblock __meminit
>> -#define __initdata_memblock __meminitdata
>>  void memblock_discard(void);
>>  #else
>> -#define __init_memblock
>> -#define __initdata_memblock
>>  static inline void memblock_discard(void) {}
>>  #endif
>>  
>> -- 
>> 2.34.1
>> 
>> 
>
>-- 
>Sincerely yours,
>Mike.

-- 
Wei Yang
Help you, Help me

