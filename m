Return-Path: <linux-arch+bounces-11416-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63834A8B89D
	for <lists+linux-arch@lfdr.de>; Wed, 16 Apr 2025 14:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 593BC5A30A5
	for <lists+linux-arch@lfdr.de>; Wed, 16 Apr 2025 12:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF3A24BCF9;
	Wed, 16 Apr 2025 12:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=atlas.cz header.i=@atlas.cz header.b="ffXnmbnp"
X-Original-To: linux-arch@vger.kernel.org
Received: from gmmr-4.centrum.cz (gmmr-4.centrum.cz [46.255.227.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CEA247299;
	Wed, 16 Apr 2025 12:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.227.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744805361; cv=none; b=ioL0lB8aWw0c/zeSczSIgX1ZZMyJVpgfl1CdhaG6ccWtbMKazToL+CnLHN3cbtgkOgvS5EvKnuWyByWSbuLdehjRFUERLDP1lkYppakik/n2uRzAoXVkPlRmW6WqsGG8JaMjcbVCP8ik1ZtywkR/MMlC8iGgDQlZIoML4iCW0RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744805361; c=relaxed/simple;
	bh=bC+wM2T34xrbS+z7qOGcYi41w2WvMWPbKGOecdh/KE4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EfulK9CxYqnDnrJM/QWXGWzjFRHz0/kD3Hb6Z115x7L0LYwqv0fsn1O0egj7yp7PQmsayn14rwcEFPPbvU9YPP/xXtkNOh1TLAUNCL7JrpP59MarxjQGrCU8vc2xY6t/QefzXemblWpQdqqt0azNGeI4mNllUuXVpyIqlIDGdVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atlas.cz; spf=pass smtp.mailfrom=atlas.cz; dkim=pass (1024-bit key) header.d=atlas.cz header.i=@atlas.cz header.b=ffXnmbnp; arc=none smtp.client-ip=46.255.227.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atlas.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atlas.cz
Received: from gmmr-4.centrum.cz (localhost [127.0.0.1])
	by gmmr-4.centrum.cz (Postfix) with ESMTP id CF7F4DD84;
	Wed, 16 Apr 2025 14:07:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=atlas.cz; s=mail;
	t=1744805243; bh=hMk+qfxHbBWbPWBjMAT1Mzk1thocsa4qoSF/uO2OysQ=;
	h=Date:From:To:Cc:Subject:From;
	b=ffXnmbnpKMY9AI69+AWKnXsTfApq8fHgh6lvKENvC3ZVYsaVkG7SnLN2F5ccgLhAi
	 +qLajXe2Rfrbd/A22glhqgW5fMw4QQjpTVwKUj3AdNgiOG3V2AMzUsFgZLExQ0Do04
	 AgJZ62+JXJ27IeLXcEhkGs9AkieHEy92A/K7v4K0=
Received: from antispam27.centrum.cz (antispam27.cent [10.30.208.27])
	by gmmr-4.centrum.cz (Postfix) with ESMTP id B1EBC201C973;
	Wed, 16 Apr 2025 14:07:23 +0200 (CEST)
X-CSE-ConnectionGUID: 5uW907vFTYuypfPIRE964Q==
X-CSE-MsgGUID: gD2ADJ/PSN2HBoS5sauQbg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A2EHAAAFnP9n/0vj/y5aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQAmBOAMBAQEBCwGDQIFkhFWRcYoniAWGDoVbgX4PAQEBAQEBA?=
 =?us-ascii?q?QEBCTsJBAEBAwQ3AYFUgnSLLic2Bw4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBB?=
 =?us-ascii?q?gEBAQEBAQYGAQKBHYU1Rg2CYgGBJIEmAQEBAQEBAQEBAQEBHQINgSdWKA0CH?=
 =?us-ascii?q?wcCcYMCAYIvATQUBrIlgTIaAmXccAKBI2OBJAaBGi4BiE8BhWyFOYINgRWDK?=
 =?us-ascii?q?j6BBQGHGIJpBIItgReQa4VrinKBTRwDWSwBVRMXCwcFgWwDgQ9xNR2BeoNzh?=
 =?us-ascii?q?TaCEYIEiROEVi1PhRsdQAMLbT03FBsGmGeEFnsnGBcJgSUVLpNgkAWjJoMcg?=
 =?us-ascii?q?QkFhEmHS5VKM5dwA5JkLodlj3J5jAyBeZVaKoUqgVAeDYICMyIwgyITPxmOP?=
 =?us-ascii?q?AQHCxaIVcNZdgIBATgCBwsBAQMJgjuNYYFLAQE?=
IronPort-PHdr: A9a23:GRsetBwIpJQwf37XCzL1zFBlVkEcU1XcAAcZ59Idhq5Udez7ptK+Z
 xaZva0m1gWXBtyTwskHotSVmpioYXYH75eFvSJKW713fDhBpOMo2icNO4q7M3D9N+PgdCcgH
 c5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFRrhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTezf79+N
 gm6oRneusUIn4dvK6g8xgbUqXZUZupawn9lKl2Ukxvg/Mm74YRt8z5Xu/Iv9s5AVbv1cqElR
 rFGDzooLn446tTzuRfMVQWA6WIQX3sZnBRVGwTK4w30UZn3sivhq+pywzKaMtHsTbA1Qjut8
 aFmQwL1hSgdNj459GbXitFsjK9evRmsqQBzz5LSbYqIL/d1YL/Tcs0GSmpARsZRVjJOAoWgb
 4sUEuENOf9Uo5Thq1cSqBezAxSnCuHyxT9SnnL406003fo/HA/b3wIvEM4Bv2nPodXpKKsfS
 /y5wLXUwTjBaf5dxDfz6JLPchAkufyCR6x/cdbLyUIyGAzKlFOQrJLmPziI0ekCqXKb7+l6W
 uKqkWEnsRp8rSKzxscokIbJnZgZxUzF9Chgxos+ONK3RlJhb9G+DJtQqz+VN5FwQs46TWxlu
 yc3x6EItJC0YSQHxpQpyhreZvKIb4WF/wzvWeePLTl2mX5od6+zihSy/0Wk1+HxWcm53VJXo
 yZYnNfBuHYA3AHd5MiAT/ty5Eah2TCX2gDQ9O5EO0Y0mrTfK5I7xb4wjJUTvELeFSH1gEX7l
 KCbe0Q+9uS26+nqYq/qqoGCO4J2kA3zMKQjltShDeglPAUCRXaX9fqg2LH540H0T6lGgucyn
 6TYtp3RON4VqbSjAwBP14Yu8xO/DzC739sGhXQHN1dFeA6fj4juJlHOPOj0DfehjFSolzdm3
 //GPrj4DpXWK3jDjK/hcatg50JG1AU809Zf545OCrEcJfL/QFP+td3AAh84NQy73frnBc1y2
 44fQ26DHK+UPaPIvVOW+O4iIfOAaY0VtTrlLvgq/f/ujXs3mV8Heqmp2IMaZ2qiHvRlOUqZZ
 GDjgs0aHGgQogo+SPbliEaYXTFPZne+R7g86S0jCIK6EYfDQZiggL+f0yelH51WYHpKBUuWE
 XfvaoqEQPQMaSKJL8B7iDwEUKKtRJMm1RGrrAP60aZoLvLI+i0EspLuzNd06u7SmBwp9jx7E
 d6d02eTQGFwhG8IQCU23K9nrUxn1liDybR4g+BfFdFL4/NJUwE6NYPTzuBjDtDyXxnMftSXS
 Fm8XtqmAis9TtUrw98Be0p9Acmtjgjf3yq2BL8Yj6aEBJ8s8qLZxHXxI8d9y3Db1KgullUmT
 MxPNXCghqFi7QfTG4/Jk0Kfl6qwcqQcxiHN+H+ZzWWSpEFYTBJwUaLdUHEQeETWq8316V7cQ
 L+wF7snNhBMycqDKqtRdt3plk9KRfj9N9TYe2KxgWCwBRSWybyQcIrmYWId3D/SCEQciQAc4
 W6GNRQiBiemu2/eCD1uFVTyY0Lj6OVxsmm7QVM0zwyRcU1h2KS6+gQPifyfVfwTxLQEtzklq
 zluG1a9xd3WB8KapwV9ZKVcfc894FBf2GLdtgx9OIGgLq97il4dbQt3pUXu2AtzCohbj8gqo
 20lzBBoJaKbzlxBbTWY0o70OrHNLWny5h+vZ7bQ2l7FyNmW4LsA6Owkq1X/uwGkDkgvoD1b1
 IxR0n2B9tDJARAUXJbZTEk67V55qqvcby174JnbhlN2NqzhijLewZoXDe2GyV70ds1cOaaND
 if7D8kTHI6lOrp5yBCSchsYMbUKp+YPNMS8eq7DgfbzVNs=
IronPort-Data: A9a23:QP9PJq71x5ZGZTL7JkMB1wxRtOjGchMFZxGqfqrLsTDasY5as4F+v
 msfCmmBOqrZNGGmKNslO43noUsAuMLcn4VrGwE9+S49Zn8b8sCt6fZ1j6vT04F+CuWZESqLO
 u1HMoGowPgcFyKa+1H0dOC88BGQ7InQLpLkEunIJyttcgFtTSYlmHpLlvUw6mJSqYHR7zil5
 5Wr/qUzBHf/g2Qpaj5NtfrZwP9SlK2aVA0w7wFWic9j4we2e0k9VPo3Oay3Jn3kdYhYdsbSb
 /rD1ryw4lTC9B4rDN6/+p6jGqHdauO60aCm0xK6aoD66vRwjnVaPpUTaJLwXXxqZwChxLid/
 v0W7MDtFl15VkH7sL91vxFwS0mSNEDdkVPNCSDXXce7lyUqf5ZwqhnH4Y5f0YAwo45K7W9yG
 fMwdS0yP0jcmcyK8a+qUudUp/4OfZe3BdZK0p1g5Wmx4fcOTpWGWKDW/YYBmjw9gNxUAPOYb
 NhxhThHMEqGOUASfA1NV9RhwY9EhVGmG9FcgFuPpqMy6nL7xRB12aOrO8i9ltmiHpwJzh3B/
 T+Xl4j/Kh42bvWz6329yVT2psXIpn7gUZ8rHrLto5aGh3XWnAT/EiY+VlaloP//gFS5V8lcO
 mQd4C9opq83nGS7HofVXBCipnOA+BkGVLJ4F+w89RHIz6/84BiQDWtCSSROAPQvt9czbTgr0
 EKZ2t3uGDpjuaGUTnTb8a2bxRuiNC5QIWIcaCssSQoe/8KlsIw1lgjITNtoDOiylNKdMTXxx
 S2a6SEkjLU7k8EGzeO48ErBjjbqoYLGJiYx5wPKTiem4xl/aYqNeYOl8x7Y4OxGIYLfSUOO1
 EXogODCsqZUUMzLznbSBrpQdF2028u43PTnqQYHN/EcG/6FoiXLkVx4iN2mGHpUDw==
IronPort-HdrOrdr: A9a23:DOnhbKuMeEAHweiXCbPzomM+7skDbdV00zEX/kB9WHVpmwKj+P
 xGuM5rtyMc6QxhO03I9urrBEDtex7hHP1OgbX5X43CYOCOggLBR72KhrGN/9SPIUHDytI=
X-Talos-CUID: =?us-ascii?q?9a23=3AorHX+Wl3yHejUmrLBF+mHlpYsorXOSDA8yaIfFG?=
 =?us-ascii?q?WNVd0WaWbcX6q1fI6z/M7zg=3D=3D?=
X-Talos-MUID: 9a23:Gb5AwAYMihoUEeBTuBO2rR1Ac/9Txf6OIkc2zI4PpvCOOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,216,1739833200"; 
   d="scan'208";a="314831359"
Received: from unknown (HELO gm-smtp11.centrum.cz) ([46.255.227.75])
  by antispam27.centrum.cz with ESMTP; 16 Apr 2025 14:07:22 +0200
Received: from arkam (ip-213-220-240-96.bb.vodafone.cz [213.220.240.96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gm-smtp11.centrum.cz (Postfix) with ESMTPSA id A05CB100AE2A3;
	Wed, 16 Apr 2025 14:07:22 +0200 (CEST)
Date: Wed, 16 Apr 2025 14:07:20 +0200
From: Petr =?utf-8?B?VmFuxJtr?= <arkamar@atlas.cz>
To: linux-kernel@vger.kernel.org
Cc: Kevin Brodsky <kevin.brodsky@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	x86@kernel.org, xen-devel@lists.xenproject.org,
	linux-arch@vger.kernel.org
Subject: Regression from a9b3c355c2e6 ("asm-generic: pgalloc: provide generic
 __pgd_{alloc,free}") with CONFIG_DEBUG_VM_PGFLAGS=y and Xen
Message-ID: <202541612720-Z_-deOZTOztMXHBh-arkamar@atlas.cz>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi all,

I have discovered a regression introduced in commit a9b3c355c2e6
("asm-generic: pgalloc: provide generic __pgd_{alloc,free}") [1,2] in
kernel version 6.14. The problem occurs when the x86 kernel is
configured with CONFIG_DEBUG_VM_PGFLAGS=y and is run as a PV Dom0 in Xen
4.19.1. During the startup, the kernel panics with the error log below.

The commit changed PGD allocation path.  In the new implementation
_pgd_alloc allocates memory with __pgd_alloc, which indirectly calls 

  alloc_pages_noprof(gfp | __GFP_COMP, order);

This is in contrast to the old behavior, where __get_free_pages was
used, which indirectly called

  alloc_pages_noprof(gfp_mask & ~__GFP_HIGHMEM, order);

The key difference is that the new allocator can return a compound page.
When xen_pin_page is later called on such a page, it call
TestSetPagePinned function, which internally uses the PF_NO_COMPOUND
macro. This macro enforces VM_BUG_ON_PGFLAGS if PageCompound is true,
triggering the panic when CONFIG_DEBUG_VM_PGFLAGS is enabled.

I am reporting this issue without a patch as I am not sure which part of
the code should be adapted to resolve the regression.

Let me know if I forgot to mention something important.

Cheers,
Petr

[1] a9b3c355c2e6 ("asm-generic: pgalloc: provide generic __pgd_{alloc,free}")
[2] https://lkml.kernel.org/r/20250103184415.2744423-6-kevin.brodsky@arm.com

[    0.396244] mem auto-init: stack:all(zero), heap alloc:off, heap free:off
[    0.398164] software IO TLB: area num 2.
[    0.449383] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.452043] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888003450000 pfn:0x344e
[    0.454715] head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[    0.456908] flags: 0x10000000000040(head|node=0|zone=1)
[    0.458390] raw: 0010000000000040 ffffffff82850ed0 ffffffff82850ed0 0000000000000000
[    0.460621] raw: ffff888003450000 ffff888003454000 00000001ffffffff 0000000000000000
[    0.462807] head: 0010000000000040 ffffffff82850ed0 ffffffff82850ed0 0000000000000000
[    0.464928] head: ffff888003450000 ffff888003454000 00000001ffffffff 0000000000000000
[    0.467106] head: 0010000000000001 ffffea00000d1381 ffffffffffffffff 0000000000000000
[    0.469263] head: 0000000000000002 0000000000000000 00000000ffffffff 0000000000000000
[    0.471430] page dumped because: VM_BUG_ON_PAGE(1 && PageCompound(page))
[    0.473338] ------------[ cut here ]------------
[    0.474764] kernel BUG at include/linux/page-flags.h:527!
[    0.476473] Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[    0.478294] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.13.0-rc6-00187-ga9b3c355c2e6 #41
[    0.480971] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-20240910_120124-localhost 04/01/2014
[    0.484218] RIP: e030:xen_pin_page+0x5e/0x180
[    0.485580] Code: f0 48 0f ba 2e 0a 73 24 48 83 c4 08 5b 41 5c 41 5d 41 5e 41 5f 5d e9 a1 75 e1 00 48 c7 c6 68 70 58 82 48 89 df e8 c2 da 30 00 <0f> 0b 49 bd 00 00 00 00 00 16 00 00 31 ff 41 89 d4 48 b8 00 00 00
[    0.491414] RSP: e02b:ffffffff82803d18 EFLAGS: 00010046
[    0.493064] RAX: 000000000000003c RBX: ffffea00000d1380 RCX: 0000000000000000
[    0.495294] RDX: 0000000000000000 RSI: ffffffff82803b68 RDI: 00000000ffffffff
[    0.497513] RBP: ffffffff82803d48 R08: 00000000ffffdfff R09: ffffffff82925148
[    0.499723] R10: ffffffff828751a0 R11: ffffffff82803a88 R12: ffff88800344e000
[    0.501940] R13: ffff88808344e000 R14: ffff88800344e000 R15: 0000000000000100
[    0.504180] FS:  0000000000000000(0000) GS:ffff88803aa00000(0000) knlGS:0000000000000000
[    0.506699] CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.508485] CR2: ffffc90000a00000 CR3: 0000000002842000 CR4: 0000000000000660
[    0.510648] Call Trace:
[    0.511420]  <TASK>
[    0.512071]  ? show_regs.part.0+0x1d/0x30
[    0.513315]  ? __die+0x52/0x90
[    0.514282]  ? die+0x2a/0x50
[    0.515189]  ? do_trap+0x10e/0x120
[    0.516255]  ? do_error_trap+0x6e/0xa0
[    0.517453]  ? xen_pin_page+0x5e/0x180
[    0.518611]  ? exc_invalid_op+0x52/0x70
[    0.519805]  ? xen_pin_page+0x5e/0x180
[    0.520936]  ? asm_exc_invalid_op+0x1b/0x20
[    0.522245]  ? xen_pin_page+0x5e/0x180
[    0.523424]  ? xen_pin_page+0x5e/0x180
[    0.524596]  __xen_pgd_walk+0x2a0/0x2d0
[    0.525816]  ? __pfx_xen_pin_page+0x10/0x10
[    0.527116]  __xen_pgd_pin+0x4d/0x180
[    0.528288]  xen_enter_mmap+0x25/0x40
[    0.529431]  poking_init+0x53/0x130
[    0.530558]  start_kernel+0x4a7/0x6f0
[    0.531726]  x86_64_start_reservations+0x29/0x30
[    0.533197]  xen_start_kernel+0x6cf/0x6e0
[    0.534466]  startup_xen+0x1f/0x20
[    0.535497]  </TASK>
[    0.536193] ---[ end trace 0000000000000000 ]---
[    0.537676] RIP: e030:xen_pin_page+0x5e/0x180
[    0.539049] Code: f0 48 0f ba 2e 0a 73 24 48 83 c4 08 5b 41 5c 41 5d 41 5e 41 5f 5d e9 a1 75 e1 00 48 c7 c6 68 70 58 82 48 89 df e8 c2 da 30 00 <0f> 0b 49 bd 00 00 00 00 00 16 00 00 31 ff 41 89 d4 48 b8 00 00 00
[    0.544954] RSP: e02b:ffffffff82803d18 EFLAGS: 00010046
[    0.546553] RAX: 000000000000003c RBX: ffffea00000d1380 RCX: 0000000000000000
[    0.548821] RDX: 0000000000000000 RSI: ffffffff82803b68 RDI: 00000000ffffffff
[    0.551022] RBP: ffffffff82803d48 R08: 00000000ffffdfff R09: ffffffff82925148
[    0.553233] R10: ffffffff828751a0 R11: ffffffff82803a88 R12: ffff88800344e000
[    0.555420] R13: ffff88808344e000 R14: ffff88800344e000 R15: 0000000000000100
[    0.557365] FS:  0000000000000000(0000) GS:ffff88803aa00000(0000) knlGS:0000000000000000
[    0.559528] CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.561050] CR2: ffffc90000a00000 CR3: 0000000002842000 CR4: 0000000000000660
[    0.562970] Kernel panic - not syncing: Attempted to kill the idle task!
(XEN) Hardware Dom0 crashed: rebooting machine in 5 seconds.
QEMU: Terminated


