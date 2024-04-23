Return-Path: <linux-arch+bounces-3909-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4958AE13D
	for <lists+linux-arch@lfdr.de>; Tue, 23 Apr 2024 11:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E8341F2339C
	for <lists+linux-arch@lfdr.de>; Tue, 23 Apr 2024 09:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDEB59151;
	Tue, 23 Apr 2024 09:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Tr6T8d3n"
X-Original-To: linux-arch@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C480F56B9D;
	Tue, 23 Apr 2024 09:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713865544; cv=none; b=cPBlr+IkZ+23k8QXM8100ZhkJz67U3AscoaR08vwLXVa1Tv5Y7cSD2ixoFpMUtb5xCaSCIRSEk+ZA0w63RczfcKaygkSEi8ViLW36mkUG1+tOlwr9xjhOK+1SE5Tz1nVSun8rA3gRdXHX42rnw2KM603FDlZI4A9Pq2c/NLahQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713865544; c=relaxed/simple;
	bh=unf/IKr9VmLOe/XGqyE5/FCvp/8jpLFn08Ee3ayn9vE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=FNtpK30RyIdq+cDU1VwbpG5a0C/1h5jEBDNloEsrb4wxb+/xkuNYqsNqPkncySX6rONuz95NldPlHCNJ7IUBE04A4f6DxJ+8M/GQbm8EUMom4mdGnUOx77XgkKfrYYak474tFlw1pld6dEV7F3QaTLbA8cdwwEGvlulW7OZ2NLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Tr6T8d3n; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713865502; x=1714470302; i=markus.elfring@web.de;
	bh=unf/IKr9VmLOe/XGqyE5/FCvp/8jpLFn08Ee3ayn9vE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Tr6T8d3n2Z6QotE4Ah2/GuNN+n+H0MPh+Rib8eT9ZHFctn5z9bzoGFJa7fBLb89w
	 PgQSmRGgsBjwGxyWM3dUQx9cV91Gyy03JNqIXHJD941+Q+JIy1cTMlKHnFTv8URBk
	 aCkZG187W/mp6/Ao9Gq/vnfDdpZsL6tp0MgIH2U3ZLRkfziVmLk/K9rbSSeaGzfPZ
	 0DpZdTl/aOTM7bLgeXM+oGSPj8MW/1aS1SugoA8Qts8gWt6BDO1LsJWjazsx6qdM3
	 DyPkUTdCAzSjJNsCniEOBibmjgLqFuMU2JteTOxv8XLi6USby5YIHlu2R2xOFdgkp
	 HQS/2Woaz2DrPKY/Qg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MjPQ6-1sR9k73YkM-00hArN; Tue, 23
 Apr 2024 11:45:01 +0200
Message-ID: <1f15f7e3-32ff-486f-8e6f-bbe9183b05e5@web.de>
Date: Tue, 23 Apr 2024 11:44:55 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Huacai Chen <chenhuacai@loongson.cn>,
 Jiantao Shan <shanjiantao@loongson.cn>, loongarch@lists.linux.dev,
 loongson-kernel@lists.loongnix.cn, linux-arch@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Guo Ren <guoren@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Xuefeng Li <lixuefeng@loongson.cn>, Xuerui Wang <kernel@xen0n.name>
References: <20240423074257.2480274-1-chenhuacai@loongson.cn>
Subject: Re: [PATCH] LoongArch: Fix access error when read fault on a
 write-only VMA
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240423074257.2480274-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5aAF/++CnrqQb4hr3ZNQgDjqdbWXV8FiY70vkX5EAL9c+pMnohp
 sKY5V/AoYCKJqdNqip9JJNcWrXuJfNvdZwzjZaLSkSq/mUjGiu4hVt3P/fBig1peL/Gl+cb
 P9HLBr4deryChgh/8nLct4XJM5XFQhZZlSkCVcum+5nO9kdvpMy22gS7NFaLB9t6SKz1hft
 wvb8Rwojp2UmKg/xrsVeA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uxmvR4l/YWM=;moCV0Xu1L3eQa1QE3ayecdIt6yI
 TFwIiOzdVBTn1XS7iqW/d+WA80gDD8hWX8R458DMLrZWMWJkL887aXirdoajoDlX2j0/7aA6/
 5E2CEn2U2K9LWRORqLHkA/YhmUh0uBf3z7Eny3RmQMW46PgDKa6zUC0m0RP1gjMdDBn1ll1i9
 3Gqg763E+MrPz/V47ZIyEfaM8O7xzUkYjev1P0pqAXQ9I73mJtT9+gTe9tAGbPnQjvB0pPXD1
 C6mkWZZuWdo9upJG0F48diq83XqbiJqFpQlkt3yAfBlNQ+XJhuqjMajL0kyVrRwwJALlj3tlE
 4Q8CkFfl5ADIzGL6SHlfwwr7mjyuWMsKpsTqDTtk3pe+B2bl4n0xiIoMAzcHrQ9WaPkTZkkdG
 yP9U7Tn0DewYHscBzIpn09XDQhGsmNpYJTThlKudftUe2eCgX+5emdmWG1R0uTwMv/2yrRqcp
 gZWrinbZ0kRNYdOwCDHH02bewpnMIAdAp4rYKlvHREaktT5yubOy7j0nVyvgJal5r6g8dnvYZ
 ijYq/jrG2Sssc4Y3pBNOm9U8YkHY4hS2TpQRDdYoD817pOjto7TRBBxzwFThBkbNZ5abFT84F
 l++U4l98nVtct94Q/Yf8TfRsYEghVt1Zae4crHi9dDqyX7c5fmroIOk0yB44XfTQzfTtbJ23x
 TNlHEayPqfruBhlthohHs92c8hjE8wko5nY+O8WBklVGv2IvywPlmrdxNKJffBDGI/eeRGBlU
 +CaJx/7Cxcw1/HwK0wgEs4nbGwqaF5lpSHGpzpd2lxs7J0MDrjuBoi4hboaEMirmIt7ZgZRkV
 T7RbDHhJ1JomBCsixaL4mpI2UXiN7Mtbp9w5t1KWc/CTE=

> As with most architectures, allow handling of read faults in VMAs that
> have VM_WRITE but without VM_READ (WRITE implies READ).
=E2=80=A6

Will the tag =E2=80=9CFixes=E2=80=9D become relevant here?

Regards,
Markus

