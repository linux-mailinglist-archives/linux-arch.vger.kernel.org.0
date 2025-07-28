Return-Path: <linux-arch+bounces-12973-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33686B13E5C
	for <lists+linux-arch@lfdr.de>; Mon, 28 Jul 2025 17:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D16E84E13F5
	for <lists+linux-arch@lfdr.de>; Mon, 28 Jul 2025 15:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FF02727EC;
	Mon, 28 Jul 2025 15:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HFULu9mC"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D47C273D6E
	for <linux-arch@vger.kernel.org>; Mon, 28 Jul 2025 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753716544; cv=none; b=c3uVBakTG8rtAmU/F3WUUjg/SOSG4mTSKmYevJNX5jNc/VtJb1yQz6B0AKbn/HrGDv2rq4SgvT3Tg55ijT3tpGqmPDvDS57JSR3ymI7O49pNG3kWFce+YSB4TLLABzyEP62KkBDJHQ8YR4e6Gr0TC/pX63uPlSkWgOM+WRLEx4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753716544; c=relaxed/simple;
	bh=p6MN+Bu2Jb5/LJAFhJS01PO+Gzukc7lIH4P7x8T+UaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KLVbUirL9umFMjO6UZocNX2LaWiWPf07nbqRZ8wxbobYxT52k1QC+gqX6IV+vpt3cALxHMjIuWXImdUKlnThwbMK8zNwVO48o08lKu7tMBj7jrDbVuiEpSxATPIM3ADcGIBcDruCIvGnPg01TGbsG4YtKy7HepAaywuFAom8LP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HFULu9mC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=MUAxr81O75BjtzwkUftLSmn9zrZcUMS8SkgxDTq6MVw=; b=HFULu9mC2xJrVn4BhVcKGStCZp
	T5cFgAa73UDKaPYaUfnIhzrPX+467o2XeD9b8Guv9XsTwyJITC6Wpl6YN6zp7SvRckOyWF+ee3xDW
	gTqcx59CW79Rb+gAS22/6J+BjMXfet751kboPzj2aYRkZ5lKS8KZLRlSV05/Hp4yws3OKqcyu8Nx6
	cemXR3gnvlcVsyTgS9yGkp2XRYmwDPHREaGS4XnQkzUzKx83gPogYhxIQPNUt60voj1cc0HUvx+q9
	9rw2uwjOfFvdf4ui76RfhIuz8rJqE2Ix6il5pL3DSv3M+dJQ+d6quFa7z7RJf67+ujEsRofLZjE8d
	1fzg1rnQ==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugPmU-0000000EobJ-41zE;
	Mon, 28 Jul 2025 15:28:51 +0000
Message-ID: <dcc88c8f-9330-4e1c-9ee4-4e0dfe7bda71@infradead.org>
Date: Mon, 28 Jul 2025 08:28:50 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] um: Add initial SMP support
To: Johannes Berg <johannes@sipsolutions.net>, Tiwei Bie
 <tiwei.bie@linux.dev>, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org, tiwei.btw@antgroup.com,
 linux-arch@vger.kernel.org
References: <20250727062937.1369050-1-tiwei.bie@linux.dev>
 <20250727062937.1369050-10-tiwei.bie@linux.dev>
 <233c916a5c598ca246b3138d13aaad44fdde68b2.camel@sipsolutions.net>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <233c916a5c598ca246b3138d13aaad44fdde68b2.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/28/25 3:47 AM, Johannes Berg wrote:
>> +int smp_sigio_handler(struct uml_pt_regs *regs)
>> +{
>> +	int cpu = raw_smp_processor_id();
>> +
>> +	IPI_handler(cpu, regs);
>> +	if (cpu != 0)
>> +		return 1;
>> +	return 0;
> nit: "return cpu != 0;" perhaps

	return !!cpu;

-- 
~Randy


