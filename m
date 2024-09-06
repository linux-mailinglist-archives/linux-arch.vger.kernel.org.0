Return-Path: <linux-arch+bounces-7104-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6C896F08B
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2024 11:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 664C41C20823
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2024 09:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92CF1C9DED;
	Fri,  6 Sep 2024 09:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="JRZJEoBD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YbuZKsYy"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758A413CFB6;
	Fri,  6 Sep 2024 09:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725616566; cv=none; b=adBUzLjbZZeW4/TorWldShE0AjYxHXER0lBCG9NYYgmass1qVzJ+Rb/2pos9U0ALG8Bdxfx5F8cki6lk62KWugaz1cW6HWVm+4LJuY79dth/lsKut/0sCqPAGExsh7mfocgpl1w6RVPvjsPb6QpubEwVQ13CyaUSV6MqWszjOd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725616566; c=relaxed/simple;
	bh=gUUvPOjWWjObJ8l/tpxlAMuAowT/tNkWWi/REiyptbc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=g0RveAz/cGOgC8/UW8yjyFAgo8Efh462/9MSCcVwKExO2O+Z1p2NG98PVi9JD5GQ0tAhzSYmKf8kGbW4Y++ON3tnvFMiJXrfdoKA4AI0ASWoaclM1c8vwzOFD18jKzyAlOsZhuGGXx2y7O5uZ8JGjgyb3DH3zSYOUYv3tutxCL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=JRZJEoBD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YbuZKsYy; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 8D7481380406;
	Fri,  6 Sep 2024 05:56:03 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Fri, 06 Sep 2024 05:56:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1725616563;
	 x=1725702963; bh=spCdL3tE0yzwRJuzWoP/dh86M1NxHAaaOfguj/M3bzI=; b=
	JRZJEoBD7E03AtrbWnWmR/E4Bky06zQyVOaqEDrYtzVCYUtVqqML6vpNkpePZvmu
	LkDh6ZKUYFxJIhFekagPIpis+EvEHIBr/7jMAKJCx4Mp0eFXfjOxw4omuLvqxgqq
	yopa3r5GTd6Dz3crswRx7hsJ7t/FqRvEwoY6w6ScKbyAV1eQttm8AKxhpPqlNYjU
	9JD/6Z9/Sox2d8GPcqjQb3jreF0sJhqOjKP6b8Q9pi23HKr0G3Q2i9oKPk62DsQi
	bnERniHGyUEeY9laCvDrkugc4NYwfP/OCnL8b9dt+urZV20UCu5ikrb+SDJqWKSB
	6zYPX7cpruqXL/kbX7r6Sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725616563; x=
	1725702963; bh=spCdL3tE0yzwRJuzWoP/dh86M1NxHAaaOfguj/M3bzI=; b=Y
	buZKsYyDBXnvApXrykY/L9TZDdHeKiS5BvrOg1KjB4lbLjI+Pz1jBrWfjCBGz7b6
	QXoSEn7Sp5lgP8KIwTf+hpIAuN6xMt+Dud9rMLf9h9nNfQXz+kLEj1T1fYuiKkDn
	xo2M7cYQuagF0gPBh4D2qe1Wm8EMnc4zc2xpnH+h3RJCYoBoNbhpLVM7n2DrBQve
	nOJIj1atr+y+akqlq99cnqMu0Y1Z41cYcQ6TazzWs/WDPHXiYWR3Qw9WjMENBVX2
	iUJ0akO/5txv9gEcf9lT9E+LbAUOH02gMaeLaylnY6s67cj7xFzlL+qqk6Ct/Ig/
	6GGTCcVbscbDGcLe6hjUA==
X-ME-Sender: <xms:s9HaZg6T99twwNpEAUrg5EMam6_B2aHEhP2d_0uPbtGSUObGn3qT3Q>
    <xme:s9HaZh5NZhMxeB34qIKrdxYW9sIdBeQtetUXCpcOF3KjfuOVbQCtzH8LOB7VyjGqv
    BZtDrk_Wx610_rXHfA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeiuddgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhepvdfhvdekueduveffffetgfdvveefvdelhedvvdeg
    jedvfeehtdeggeevheefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepuddu
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdgrrhgthhesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgtshhkhiesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkshgvlhhfthgvshht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqmhhiphhsse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphgrrhhishgt
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshefledtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshhhsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhprghrtghlihhnuhigsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:s9HaZvch4D5vjjeEUW8mCIns9gzXdDSCUK38eMYIOGz553WMOPB-_A>
    <xmx:s9HaZlLMieryUgKfA90cp4bUrWxNAVkU-wPsVZ-4KCgHhrZXR664VQ>
    <xmx:s9HaZkJvGV5rxrgidiv5v1AmF2Mr8SvDBii6qhVDEiQ_2ikC_UI0NQ>
    <xmx:s9HaZmxHiDjy7TaPbAFN7scjDMfoVG7YWIlY3lLlwksDsPAwcRm4GA>
    <xmx:s9HaZhBWotF2O5UX0Guk6WHI5NDPU9Edg2euSCzo2MFXf-Zyq83idrXt>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E5FF5222006F; Fri,  6 Sep 2024 05:56:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 06 Sep 2024 09:55:42 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: guoren <guoren@kernel.org>
Cc: "Charlie Jenkins" <charlie@rivosinc.com>,
 "Richard Henderson" <richard.henderson@linaro.org>,
 "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>,
 "Matt Turner" <mattst88@gmail.com>, "Vineet Gupta" <vgupta@kernel.org>,
 "Russell King" <linux@armlinux.org.uk>,
 "Huacai Chen" <chenhuacai@kernel.org>, "WANG Xuerui" <kernel@xen0n.name>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Helge Deller" <deller@gmx.de>, "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Naveen N Rao" <naveen@kernel.org>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Gerald Schaefer" <gerald.schaefer@linux.ibm.com>,
 "Heiko Carstens" <hca@linux.ibm.com>,
 "Vasily Gorbik" <gor@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Sven Schnelle" <svens@linux.ibm.com>,
 "Yoshinori Sato" <ysato@users.sourceforge.jp>,
 "Rich Felker" <dalias@libc.org>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "David S . Miller" <davem@davemloft.net>,
 "Andreas Larsson" <andreas@gaisler.com>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, "Andy Lutomirski" <luto@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Muchun Song" <muchun.song@linux.dev>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 "Vlastimil Babka" <vbabka@suse.cz>,
 "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>, shuah <shuah@kernel.org>,
 "Christoph Hellwig" <hch@infradead.org>,
 "Michal Hocko" <mhocko@suse.com>,
 "Kirill A. Shutemov" <kirill@shutemov.name>,
 "Chris Torek" <chris.torek@gmail.com>,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-abi-devel@lists.sourceforge.net
Message-Id: <f23b18c6-1856-4b59-9ba3-59809b425c81@app.fastmail.com>
In-Reply-To: 
 <CAJF2gTTVX9CFM3oRZZP3hGExwVwA_=n1Lrq_0DQKWA+-ZbOekg@mail.gmail.com>
References: <20240905-patches-below_hint_mmap-v3-0-3cd5564efbbb@rivosinc.com>
 <20240905-patches-below_hint_mmap-v3-1-3cd5564efbbb@rivosinc.com>
 <9fc4746b-8e9d-4a75-b966-e0906187e6b7@app.fastmail.com>
 <CAJF2gTTVX9CFM3oRZZP3hGExwVwA_=n1Lrq_0DQKWA+-ZbOekg@mail.gmail.com>
Subject: Re: [PATCH RFC v3 1/2] mm: Add personality flag to limit address to 47 bits
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024, at 09:14, Guo Ren wrote:
> On Fri, Sep 6, 2024 at 3:18=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> w=
rote:
>>
>> It's also unclear to me how we want this flag to interact with
>> the existing logic in arch_get_mmap_end(), which attempts to
>> limit the default mapping to a 47-bit address space already.
>
> To optimize RISC-V progress, I recommend:
>
> Step 1: Approve the patch.
> Step 2: Update Go and OpenJDK's RISC-V backend to utilize it.
> Step 3: Wait approximately several iterations for Go & OpenJDK
> Step 4: Remove the 47-bit constraint in arch_get_mmap_end()

I really want to first see a plausible explanation about why
RISC-V can't just implement this using a 47-bit DEFAULT_MAP_WINDOW
like all the other major architectures (x86, arm64, powerpc64),
e.g. something like the patch below (untested, probably slightly
wrong but show illustrate my point).

     Arnd

diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm=
/processor.h
index 8702b8721a27..de9863be1efd 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -20,17 +20,8 @@
  * mmap_end < addr, being mmap_end the top of that address space.
  * See Documentation/arch/riscv/vm-layout.rst for more details.
  */
-#define arch_get_mmap_end(addr, len, flags)			\
-({								\
-	unsigned long mmap_end;					\
-	typeof(addr) _addr =3D (addr);				\
-	if ((_addr) =3D=3D 0 || is_compat_task() ||			\
-	    ((_addr + len) > BIT(VA_BITS - 1)))			\
-		mmap_end =3D STACK_TOP_MAX;			\
-	else							\
-		mmap_end =3D (_addr + len);			\
-	mmap_end;						\
-})
+#define arch_get_mmap_end(addr, len, flags) \
+		(((addr) > DEFAULT_MAP_WINDOW) ? TASK_SIZE : DEFAULT_MAP_WINDOW)
=20
 #define arch_get_mmap_base(addr, base)				\
 ({								\
@@ -47,7 +38,7 @@
 })
=20
 #ifdef CONFIG_64BIT
-#define DEFAULT_MAP_WINDOW     (UL(1) << (MMAP_VA_BITS - 1))
+#define DEFAULT_MAP_WINDOW     (is_compat_task() ? (UL(1) << (MMAP_VA_B=
ITS - 1)) : TASK_SIZE_32)
 #define STACK_TOP_MAX          TASK_SIZE_64
 #else
 #define DEFAULT_MAP_WINDOW     TASK_SIZE

