Return-Path: <linux-arch+bounces-12947-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1262FB11967
	for <lists+linux-arch@lfdr.de>; Fri, 25 Jul 2025 09:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBCF71CE2406
	for <lists+linux-arch@lfdr.de>; Fri, 25 Jul 2025 07:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3232264BA;
	Fri, 25 Jul 2025 07:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="cEo5gAAh"
X-Original-To: linux-arch@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F14241A8F;
	Fri, 25 Jul 2025 07:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753429867; cv=none; b=WqKzIUw6RIwfxljh824MQkiQEd0ostVoab1rbKUak/GYqk2khORcwM/piq5AsjUJZ0Bp0dLvq2lrONN1YdmqbTVvoNgY1xrr0mgm2nhiaVSO9xT8RfbIRDFw8/XBRr+46GyqINPvuffvaM1OS+iRTTKMVH+t2kuuidU8BesTikA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753429867; c=relaxed/simple;
	bh=4/vvHs77kd8pAzYMmzOAcmSimOtvxQbc08tEuGA2bl8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LDg3psr+3FOnIe4Y1jps4HOvebsL4A4ksjzpLj0zRsMKKAzlRqOjnHRvrIBwY0uzLEPoWYDqA2Dz6/ysJQI0p5rA5Q2CJhe8iuDrJ8AIT6Wpx+y/ap2ACBwcWJJrQMNUbY2aWR5g6vB90YkdZ4Se6RVjxiYFzloQ6mfZGdu6UbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=cEo5gAAh; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sOVFlvbl9upVlLlSJ+gKg+QG/EzUMWB+gqdb/rBhNqg=; t=1753429862; x=1754034662; 
	b=cEo5gAAhm02lDxNtVpWZ0CftSZDWo2bUI5Q5DNzW+abLNXO2fy2fGQequSy31xZ42ghfhFgd78v
	3n1YafGd3WyJJ6BC55Ny84eQodDx3gcrzZSa/0Q614y5e8R77iVbCE/2R0B6Ps+nhYN0hH/yIAH5z
	3tDdnUw141c5fHBfsjpIxGRBpY51eXyTvEIEzTOJkOxKcNfxxjsgMIkYnviJ2VqywJ0l3Zdtwk8Yw
	1ZgMLAnApVpWFCmJCSyeM3NG25iAtcf2UYEfdt7uGI3UCM/TBiFkgKgjdJrM4lAHHv6FmsxBXorcc
	5DBoP/HYaxgGPJD3PXXEBWDF8WDi2d1eAwhA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1ufDCd-000000026hp-3NTx; Fri, 25 Jul 2025 09:50:51 +0200
Received: from dynamic-002-245-058-127.2.245.pool.telefonica.de ([2.245.58.127] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1ufDCd-00000000chc-2Fcp; Fri, 25 Jul 2025 09:50:51 +0200
Message-ID: <ac3a117c91d27dc7eff8c22ad6bd261dd2557451.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 0/3] drop hugetlb_free_pgd_range()
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Anthony Yznaga <anthony.yznaga@oracle.com>, davem@davemloft.net, 
	andreas@gaisler.com, arnd@arndb.de, muchun.song@linux.dev,
 osalvador@suse.de, 	akpm@linux-foundation.org, david@redhat.com,
 lorenzo.stoakes@oracle.com, 	Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, 	mhocko@suse.com
Cc: linux-mm@kvack.org, sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 alexghiti@rivosinc.com, agordeev@linux.ibm.com, 	anshuman.khandual@arm.com,
 christophe.leroy@csgroup.eu, ryan.roberts@arm.com, 	will@kernel.org
Date: Fri, 25 Jul 2025 09:50:50 +0200
In-Reply-To: <20250716012611.10369-1-anthony.yznaga@oracle.com>
References: <20250716012611.10369-1-anthony.yznaga@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Anthony,

On Tue, 2025-07-15 at 18:26 -0700, Anthony Yznaga wrote:
> For all architectures that support hugetlb except for sparc,
> hugetlb_free_pgd_range() just calls free_pgd_range(). It turns out
> the sparc implementation is essentially identical to free_pgd_range()
> and can be removed. Remove it and update free_pgtables() to treat
> hugetlb VMAs the same as others.
>=20
> Anthony Yznaga (3):
>   sparc64: remove hugetlb_free_pgd_range()
>   mm: remove call to hugetlb_free_pgd_range()
>   mm: drop hugetlb_free_pgd_range()
>=20
>  arch/sparc/include/asm/hugetlb.h |   5 --
>  arch/sparc/mm/hugetlbpage.c      | 119 -------------------------------
>  include/asm-generic/hugetlb.h    |   9 ---
>  include/linux/hugetlb.h          |   7 --
>  mm/memory.c                      |  42 +++++------
>  5 files changed, 18 insertions(+), 164 deletions(-)

I have applied this series against v6.16-rc7 and booted the kernel inside a
SPARC LDOM on Solaris 11.4 without any problems.

Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

