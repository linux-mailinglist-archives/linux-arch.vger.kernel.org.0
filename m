Return-Path: <linux-arch+bounces-7441-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 893059867EE
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 23:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B78501C215E4
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 21:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7951494DC;
	Wed, 25 Sep 2024 21:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ty4V85so"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE5613E02E;
	Wed, 25 Sep 2024 21:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727298403; cv=none; b=NRAkC7Q0cFUSMBnTaOOyIIledD9Iag0DlewbsJ2HStO5SYJ8YtctSc7JlEcXvsYLlrEncpOQaP9idUrd6uZcV38lHKHOWjvXYPNqT0Dty3WfU/XLddkyPf9IhZI6xf3drcr/iZK4ch3keNPOJjhK2wYDBOHoYIeyZOgkjCp/dfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727298403; c=relaxed/simple;
	bh=ov11DCW5fbfEkeXbc3N4tknYqvWLCe6U3JzkfrFWpkU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sMlh/Df+xbZb7LfQOkzBeQayWqBDRBZNvJEiIHtV+JelViyEsdy5+fgtSp60qc6h1ONx468d+CC2762ukDUUb1Xw1AdJOIa54JXgJweANz2oDz6usOPUp672SXX5gz1YPEbgIGAVGl3MTuDJzCXjRj4SPs65KytjiPo+rnl22so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ty4V85so; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07B6C4CEC3;
	Wed, 25 Sep 2024 21:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727298402;
	bh=ov11DCW5fbfEkeXbc3N4tknYqvWLCe6U3JzkfrFWpkU=;
	h=From:To:Cc:Subject:Date:From;
	b=Ty4V85soYpqEM8sUDM/PovDueJXmKYgUPZM3jqIVSWscNGO92pmJEBZ1JtV6lKwJu
	 /VNXVBsrBStlI+XfgvZYiro5DKkIxm1ox9IPT+JTFsrByJ7QQm6NjYBoXUBQxPCXLS
	 dj5bSZq++t5pObMmZdgm5I9UMfcwcKwUA1wBFgahGj4alaWxqRSwAUTR4/2d034XBs
	 WfH5LoTr3+nivVv/e+fjWSSrGa4mL16ZuTIMzAQvCXJOw//669VS4xztlBK2UwzGsJ
	 AJOAs+o3b2GwT7zi/iHnQ4PcfCPCbxIqmRkrUIFZPDrXPvg7ncTbC16FbQwGAeeU/r
	 TTlUE0B/JK86A==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-mm@kvack.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Damien Le Moal <dlemoal@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Greg Ungerer <gerg@linux-m68k.org>,
	Helge Deller <deller@gmx.de>,
	Kees Cook <kees@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Matt Turner <mattst88@gmail.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Hocko <mhocko@suse.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arch@vger.kernel.org
Subject: [PATCH 0/5] asm-generic: clean up asm/mman.h
Date: Wed, 25 Sep 2024 21:06:10 +0000
Message-Id: <20240925210615.2572360-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

While thinking about the changes to linux/mman.h in
https://lore.kernel.org/all/20240923141943.133551-1-vincenzo.frascino@arm.com/
I ended up trying to clean up the duplicate definitions in order to
better see what's in there, and then I found a clash between two MAP_* flags.

Here is my current state, lightly tested. Please have a look at
the last patch in particular.

     Arnd

Arnd Bergmann (5):
  asm-generic: cosmetic updates to uapi/asm/mman.h
  asm-generic: move MAP_* flags from mman-common.h to mman.h
  asm-generic: use asm-generic/mman-common.h on mips and xtensa
  asm-generic: use asm-generic/mman-common.h on parisc and alpha
  [RFC] mm: Remove MAP_UNINITIALIZED support

 Documentation/admin-guide/mm/nommu-mmap.rst | 10 +--
 arch/alpha/include/uapi/asm/mman.h          | 93 ++++++-------------
 arch/mips/include/uapi/asm/mman.h           | 95 +++-----------------
 arch/parisc/include/uapi/asm/mman.h         | 79 ++++-------------
 arch/powerpc/include/uapi/asm/mman.h        | 11 +++
 arch/sh/configs/rsk7264_defconfig           |  1 -
 arch/sparc/include/uapi/asm/mman.h          | 12 +++
 arch/xtensa/include/uapi/asm/mman.h         | 98 +++------------------
 fs/binfmt_elf_fdpic.c                       |  3 +-
 include/linux/mman.h                        |  4 -
 include/uapi/asm-generic/mman-common.h      | 31 +++----
 include/uapi/asm-generic/mman.h             | 17 ++++
 include/uapi/linux/mman.h                   |  5 ++
 mm/Kconfig                                  | 22 -----
 mm/nommu.c                                  |  4 +-
 15 files changed, 125 insertions(+), 360 deletions(-)

-- 
2.39.2

Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Greg Ungerer <gerg@linux-m68k.org>
Cc: Helge Deller <deller@gmx.de>
Cc: Kees Cook <kees@kernel.org>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com> 
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Vladimir Murzin <vladimir.murzin@arm.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-mm@kvack.org
Cc: linux-arch@vger.kernel.org


