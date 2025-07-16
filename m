Return-Path: <linux-arch+bounces-12802-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 392DEB07043
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 10:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48297502294
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 08:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6578228EA62;
	Wed, 16 Jul 2025 08:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RCZVmql2"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7BA15B54A
	for <linux-arch@vger.kernel.org>; Wed, 16 Jul 2025 08:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752654034; cv=none; b=UnCXV4S/3QrevXV5QDyzAOyyBgdonBlgd/EgC8+fwsXzEN5Gw+G0obzGIR67DqH6W5miS/7vhSA6C9OVX9RTSePxbNchkqb+L0GkhadxjTE0hd8ZgXC3jyZaidMabBUx2L3rAkSkcfrwESGURf1oiUEtT7U1ZLhAiU8rfuezgwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752654034; c=relaxed/simple;
	bh=ZG7MYqbm/JPxUEcAWF86YJxPO27FFTjouJJOkXlQHXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FvwWFBNFcCeVuflO8DrPjsRPhU31b08/1NJ5+v5xA19r60XtN0HvQVCbsgSnwYSRLqBAnuFlqGWFoapIUPRXKlPbqbWeuc4H8J4aMLZMldpBFQhf+7QSqhaRQt4Ei27pdsChiMHOxloQxA7AiKlA3eywHUaqHbXgA813haY/yys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RCZVmql2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752654031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hKPb3FYVzFfrjo/nSEr903PTnJ+H6/4JdqXYfPo/qsQ=;
	b=RCZVmql2VSbCJKJmB+5GM5gRK2nlYjhZWaChQb/kvsUwEoP5nD6jFojNCTmoODsAuZUwBQ
	+B/XMQP3pw+BQi+TM0ah62IcdIpFaLgtUOUSZfOYRXn4IE6qw5mMAuSTgYOBCr/3lDAxes
	shZZZk3lvYdPTT53wbOgTuko/jhJy8I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-3cnwr0jBOzW99MZ-lAY9oA-1; Wed, 16 Jul 2025 04:20:30 -0400
X-MC-Unique: 3cnwr0jBOzW99MZ-lAY9oA-1
X-Mimecast-MFC-AGG-ID: 3cnwr0jBOzW99MZ-lAY9oA_1752654029
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-455f7b86aeeso23997415e9.0
        for <linux-arch@vger.kernel.org>; Wed, 16 Jul 2025 01:20:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752654029; x=1753258829;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hKPb3FYVzFfrjo/nSEr903PTnJ+H6/4JdqXYfPo/qsQ=;
        b=Si63UbHEjy8u8Qngre9Goj96ur20IfkDXelGDy6hPgN0ZLYpOAYAC07J8Zl9j95LET
         qxq0juz5jxHgATCrXuagsQ8crBmRZn9AHS5yKBt8z1ZWyim0+iFi2TyJ9nQRFWYB4xRZ
         EiLeGvbAPAzIDfjFa3VW0c+j5BNtl9wgOFclBsWyQXcrElreicEKkiuCIUqZUGsivJ9F
         sZY7dKuk3K0XyvOlbOI2FXasvsE2d6DWRFyYmCoSn8cA6cVS3H0m7rRoX21CE8Q9D+bd
         NRY1PgTaGK7ovYHIstlRoEPohVNqyEf+vVdAaeLXKhyF/8wLKW4+zzB8vNvETBG7XhPt
         1woA==
X-Forwarded-Encrypted: i=1; AJvYcCVqC4FDoQWxWFbqy333kP6qEsc/AuYTYeGAqGYlWcxk/fG94pm1h88qClBPGkwlWDWEGObasdf2Rvrd@vger.kernel.org
X-Gm-Message-State: AOJu0YwaApMw0F3rW9rckrlLtuHCD8BF9YaExAzSjjI3E+7c7IZXYqXJ
	yJUMe1LlwI8HrR9MrKo1/IQPY0uTVcGkRu+TxBnMTIBhSIC+VEI8W7jfV3EXxCFwNSSHbAbB5n+
	a65tLhjNiQ4erV/GA9Jhy6WuqdoYsfgsPZQNVMVPRYt/u/Pe9hDqjn5nAF4kJ+J0=
X-Gm-Gg: ASbGncuyLO0LP8xJz8Hxtl/xAjfEmS9uAYuQ+HH8AK73mFfPsvj5Y36IECWqc59tbZS
	OkmJ9xtKYqIcCwPbveLbzfWuwZ+fl7MlKAKZc1FEV00OUTZFXi/TyraUbpaKQ0CenBn44eziqnG
	/DBhhKHJi6LixMsaTSXuC2icsyXBiy9x5ReRkj4pQdEIZ3sKNK5Br7t4myVKnxlbVhnNo3Vl4tA
	ZP1PHPBVvs3pLQG5ypfTEEhILiJEqjvwAKPRbTm9Db1fPPEI8WqG+86I5e/jwyRQ93okxYGBhJ7
	KapOu0OvsBPkqomlA1dezhAZbzEvHc9M4hO0opNlZyeKiql04hjY4imM67qECDks2N5ZTjUYv6T
	QnsUZyFSiL+mInMbdGgY3Qg4Jb5/FXxrDVODRMYe9BRM4HY4iv6O5N6XN+O4+lbeWNcQ=
X-Received: by 2002:a05:600c:5025:b0:441:b698:3431 with SMTP id 5b1f17b1804b1-4562ee4428amr8903775e9.28.1752654029186;
        Wed, 16 Jul 2025 01:20:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPfO/crUSbh/p7Bf2c82O3FOkImgy2tCspzCYogys8HSUj89hQEyYWP4/UInuKY3Ru8/ZdfA==
X-Received: by 2002:a05:600c:5025:b0:441:b698:3431 with SMTP id 5b1f17b1804b1-4562ee4428amr8903515e9.28.1752654028755;
        Wed, 16 Jul 2025 01:20:28 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1d:ed00:1769:dd7c:7208:eb33? (p200300d82f1ded001769dd7c7208eb33.dip0.t-ipconnect.de. [2003:d8:2f1d:ed00:1769:dd7c:7208:eb33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e886113sm13312585e9.23.2025.07.16.01.20.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 01:20:28 -0700 (PDT)
Message-ID: <13d1fe66-9f34-47d3-b174-516ffb706aa1@redhat.com>
Date: Wed, 16 Jul 2025 10:20:26 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] sparc64: remove hugetlb_free_pgd_range()
To: Anthony Yznaga <anthony.yznaga@oracle.com>, davem@davemloft.net,
 andreas@gaisler.com, arnd@arndb.de, muchun.song@linux.dev,
 osalvador@suse.de, akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com
Cc: linux-mm@kvack.org, sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 alexghiti@rivosinc.com, agordeev@linux.ibm.com, anshuman.khandual@arm.com,
 christophe.leroy@csgroup.eu, ryan.roberts@arm.com, will@kernel.org
References: <20250716012611.10369-1-anthony.yznaga@oracle.com>
 <20250716012611.10369-2-anthony.yznaga@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Organization: Red Hat
In-Reply-To: <20250716012611.10369-2-anthony.yznaga@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.07.25 03:26, Anthony Yznaga wrote:
> The sparc implementation of hugetlb_free_pgd_range() is identical
> to free_pgd_range() with the exception of checking for and skipping
> possible leaf entries at the PUD and PMD levels.

And the pgd loop was optimized out, because probably not applicable.

> These checks are
> unnecessary because any huge pages have been freed and their PTEs
> cleared by the time page tables needed to map them are freed.

Do we know why that handling was added in the first place, and why it no 
longer applies?

These is_hugetlb_pmd/is_hugetlb_pud are rather weird on the code path.

Looks like a very nice cleanup.

-- 
Cheers,

David / dhildenb


