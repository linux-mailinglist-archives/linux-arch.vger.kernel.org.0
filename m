Return-Path: <linux-arch+bounces-14598-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FDFC44358
	for <lists+linux-arch@lfdr.de>; Sun, 09 Nov 2025 18:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC0931881A45
	for <lists+linux-arch@lfdr.de>; Sun,  9 Nov 2025 17:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB9A303A27;
	Sun,  9 Nov 2025 17:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVNrL4X5"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F272FF147
	for <linux-arch@vger.kernel.org>; Sun,  9 Nov 2025 17:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762708067; cv=none; b=NE6vE7tXTBg/wUcaHcGhq1smOl3R/FqjSg9iJvNsH6NWOFktKU8fqXojqpg59s7yZt3fvZyDl7jIFaqjFNNqr36qOj9EWhCL8u76wECy0PINCRMc5VVOVNGCaL2t5qLuScYrCvJ/LEcDIB2gMz+i8mVk8Ndc0JoVGybpa4UaYl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762708067; c=relaxed/simple;
	bh=3rqCb9e2fqvIRBJhRM5QwHp9ZvBo/t44Ip10A8761Ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DwNBdMtejucauEQU6n3sqPisRHSkzY96l2YnE1dFYFr3IEm29fw56gvifPmx9Frnz1/F5JacyFomaEnfe6VzmdHCfoHqsMgzhhWBXN6vOW9S70SkUYeKqg+Px1ksZGP2VHMkk6/a0waSfGw9hS+UZeCCm5a83WqT0czqHsee3tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVNrL4X5; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b994baabfcfso1344656a12.3
        for <linux-arch@vger.kernel.org>; Sun, 09 Nov 2025 09:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762708066; x=1763312866; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c1FNiL4lN8CLTL7WaZG1viN8SOw0TC2lym8ciARU3xw=;
        b=aVNrL4X5pm4oodCbFh3vXpVyPSHbmP2ob9O7j7+2vfmxmsC8ilNlg91DaHPM/vksKA
         I+k2tH0lN8iXD0wzxdiCqc62xt4RnX56P7IokbgFgoSKtMB7IpWAhqN9PnyKj3/bKjPh
         qUXO7i4qqhqu0MwhH0IOsaGSY1SCOi6kve45dwQB1fYpfIcOibqgB2fsRRGMWJadEk06
         OzCDq4BxmBc3NeMfnRseP7ELcd/steV/8cLh62xGo6YcQSoV9kprXO0LcsFSGCpzE0rw
         f6ahtn4eiQ5+lE7Kot76RvCtX6K8/zg88hPnz0rPat6Oy1w+4r4ORy0GWSS57+QStAcg
         yocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762708066; x=1763312866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c1FNiL4lN8CLTL7WaZG1viN8SOw0TC2lym8ciARU3xw=;
        b=MKaFL1wawLUEH3ixB+DXZKsvFsqcMr9s+mahgjvXbrVw7fyehbLjOWGjiLdi9xAi4Y
         zJ+XoLn+w1xKISH8tLkZTksdmOzmMf4Ul3EF19AhAQ60OG/Y7JUq8jw1ojKZlxRcZ0V/
         8kigj2JFdhEDWG1lpF6bsfVNdYPXnMiWqVhY4C/g7Z4IQrIp7k9hB4jM1HYn15ibveP4
         I2itZRgx7tT/QbXvNGjPt7CUa/apl0ckzf/TlD4jXHwC5Bn7iYivcOcGtyRBqcL87Ipf
         uT2ynjsaAElbtHkslAXi16TDCf+XED6WoPkG623rJg+bzOwgrkon9Y54GlFsF0w9wxpu
         hQOg==
X-Forwarded-Encrypted: i=1; AJvYcCU1y+4Wjw4lTzbq8oBNz3ysDoI8un1mwjgX6z4SBUK4GQCGq1qA0ZGPBFtNrb/9Y/uPoxVgZBwBFVye@vger.kernel.org
X-Gm-Message-State: AOJu0YwdTNjNiUW7jEoxwAwCcsx2+rx8DkPLw/wlb90Hu9mtGd+i3uLm
	S11H9SeHM2q9plBmlkiqJKSM4uLmp8sQpzbeqKtQTQDEktXyUHmLtKtg
X-Gm-Gg: ASbGncv/B/vWGBTHn2tgu7c+ctkzcgouqNggTZh1POhIBiTRk8I97fQfNpxTUep04Uv
	ABaXLsF7JPwaM76LHkOT3V9ZdQvl4tMRmDA6A75kcolUOaVVcfmi52RLgBM+HyqJUn0q6xd2iRl
	tcv71OodgTx3MlO2Di82SbRc+BD3Y4xyDZTFmtutt6pxkGy+GoKa9GpcYx2pZ3YyETjbsVbogd1
	goujLniI7B8TmXDio367dzUhtz0lHekkKXsZRP6Ua+tIbIMQaG+URmAsM3XM5H5xkpRh1n4XR/B
	7lhz2JQG0S4SbS1HmDalfsjt0hZ/mM9kAqhjKOMa5uxGu9VDxTuoZNF7quR2eEA3uaGEeuMKxXq
	4rls7OKXzIjb96IMZNARHqb7PT4O83d4OE5xEzfsRPOPD0587ZojU694NIBv02zAT8EYCenAvOO
	C84pT+r2y8ZBGTqLwOHPXDwExIRPbrwlgUDvkv36r/EgM=
X-Google-Smtp-Source: AGHT+IGaUkeabb++qUmC+bOuTrL5CUbZWgq2rW9tYf42/ySSJ2DpLXTzPR16+AhOmoYX8uvG88oLjA==
X-Received: by 2002:a17:903:fad:b0:295:9b9a:6a7f with SMTP id d9443c01a7336-297e571290cmr71731095ad.49.1762708065697;
        Sun, 09 Nov 2025 09:07:45 -0800 (PST)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c7c841sm120391455ad.72.2025.11.09.09.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 09:07:44 -0800 (PST)
Date: Sun, 9 Nov 2025 09:07:42 -0800
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Kevin Brodsky <kevin.brodsky@arm.com>, Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] mm: Remove unnecessary __GFP_HIGHMEM in
 __p*d_alloc_one_*()
Message-ID: <aRDKXmwJeosbvU6N@fedora>
References: <20251109021817.346181-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109021817.346181-1-chenhuacai@loongson.cn>

On Sun, Nov 09, 2025 at 10:18:17AM +0800, Huacai Chen wrote:
> __{pgd,p4d,pud,pmd,pte}_alloc_one_*() always allocate pages with GFP
> flag GFP_PGTABLE_KERNEL/GFP_PGTABLE_USER. These two macros are defined
> as follows:
> 
>  #define GFP_PGTABLE_KERNEL	(GFP_KERNEL | __GFP_ZERO)
>  #define GFP_PGTABLE_USER	(GFP_PGTABLE_KERNEL | __GFP_ACCOUNT)
> 
> There is no __GFP_HIGHMEM in them, so we needn't to clear __GFP_HIGHMEM
> explicitly.
> 
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

