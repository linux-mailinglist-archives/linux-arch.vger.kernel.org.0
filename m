Return-Path: <linux-arch+bounces-4389-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 068308C4D0F
	for <lists+linux-arch@lfdr.de>; Tue, 14 May 2024 09:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 389131C209F4
	for <lists+linux-arch@lfdr.de>; Tue, 14 May 2024 07:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3562B11723;
	Tue, 14 May 2024 07:32:19 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6C0101E2;
	Tue, 14 May 2024 07:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715671939; cv=none; b=RGxIwEt/gd7Wt71XEWpQ1tiOcOcLi29Jwgm9opDzn2/Ev6aT7yhDg0kduPtuNgpea38V5x4SU+PkUjrnO/eSGyhKif6Na1MMnAp7Qx7dGh+lmStmLw7NCkxjmPvhgW773hDh0NVtBYpe5GT9OB4y7FeVvO1P84y3fVmQCxxzd2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715671939; c=relaxed/simple;
	bh=FPn+wnAGRWQktpQrV94x0y/Pcc2VTrrAFwhpsP2KZFA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pOdxjoOM5CIGrfUgJSFFU5FxCCjI2/DO2mdEQPt+WIoLcnjLCHwj6qO7ehLAIDiu9XVal0OogTp1scp8zOwmiSJhl1T4p/zDOAJ8ZzbdSnc4YYKsXszZ0qX5GOZP3oPYxivn+leTGgzbG58rlczjWr489iqoD9U999EK1Wu9EVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4VdnYw6gCSz9v7JW;
	Tue, 14 May 2024 15:10:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id AF418140419;
	Tue, 14 May 2024 15:32:06 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwAXUCRnE0NmIbQfCA--.1339S2;
	Tue, 14 May 2024 08:32:05 +0100 (CET)
Message-ID: <0fbd907e411a10386bdef679864dd3d84f0fa3ad.camel@huaweicloud.com>
Subject: Re: [PATCH 0/3] kbuild: remove many tool coverage variables
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Kees Cook <keescook@chromium.org>, Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
 Alexander Potapenko <glider@google.com>, Andrey Konovalov
 <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, Vincenzo
 Frascino <vincenzo.frascino@arm.com>, Marco Elver <elver@google.com>, Josh
 Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Peter Oberparleiter <oberpar@linux.ibm.com>,  Johannes Berg
 <johannes@sipsolutions.net>, kasan-dev@googlegroups.com,
 linux-hardening@vger.kernel.org
Date: Tue, 14 May 2024 09:31:47 +0200
In-Reply-To: <202405131136.73E766AA8@keescook>
References: <20240506133544.2861555-1-masahiroy@kernel.org>
	 <202405131136.73E766AA8@keescook>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwAXUCRnE0NmIbQfCA--.1339S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCw18Kw1fCF15ur4UGw45ZFb_yoW5GFWfpr
	WrJ3WqkFWY9r10yF9Ikw1IqF1Sk397uF1Ygr909rW5AF1j9r1vvrs5trs8Z34DCws2y3W0
	yrW7XFZavr4jvaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZ18PUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQADBF1jj51HGAAAs1

On Mon, 2024-05-13 at 11:48 -0700, Kees Cook wrote:
> In the future can you CC the various maintainers of the affected
> tooling? :)
>=20
> On Mon, May 06, 2024 at 10:35:41PM +0900, Masahiro Yamada wrote:
> >=20
> > This patch set removes many instances of the following variables:
> >=20
> >   - OBJECT_FILES_NON_STANDARD
> >   - KASAN_SANITIZE
> >   - UBSAN_SANITIZE
> >   - KCSAN_SANITIZE
> >   - KMSAN_SANITIZE
> >   - GCOV_PROFILE
> >   - KCOV_INSTRUMENT
> >=20
> > Such tools are intended only for kernel space objects, most of which
> > are listed in obj-y, lib-y, or obj-m.
>=20
> This is a reasonable assertion, and the changes really simplify things
> now and into the future. Thanks for finding such a clean solution! I
> note that it also immediately fixes the issue noticed and fixed here:
> https://lore.kernel.org/all/20240513122754.1282833-1-roberto.sassu@huawei=
cloud.com/

Yes, this patch set fixes the issue too.

Tested-by: Roberto Sassu <roberto.sassu@huawei.com>

Now UBSAN complains about misaligned address, such as:

[    0.150000][    T1] UBSAN: misaligned-access in kernel/workqueue.c:5514:=
3
[    0.150000][    T1] member access within misaligned address 0000000064c3=
6f78 for type 'struct pool_workqueue'
[    0.150000][    T1] which requires 512 byte alignment
[    0.150000][    T1] CPU: 0 PID: 1 Comm: swapper Not tainted 6.9.0-dont-u=
se-00003-g3b621c71dc5e #2244

But I guess this is for a separate thread.

Thanks

Roberto

> > The best guess is, objects in $(obj-y), $(lib-y), $(obj-m) can opt in
> > such tools. Otherwise, not.
> >=20
> > This works in most places.
>=20
> I am worried about the use of "guess" and "most", though. :) Before, we
> had some clear opt-out situations, and now it's more of a side-effect. I
> think this is okay, but I'd really like to know more about your testing.
>=20
> It seems like you did build testing comparing build flags, since you
> call out some of the explicit changes in patch 2, quoting:
>=20
> >  - include arch/mips/vdso/vdso-image.o into UBSAN, GCOV, KCOV
> >  - include arch/sparc/vdso/vdso-image-*.o into UBSAN
> >  - include arch/sparc/vdso/vma.o into UBSAN
> >  - include arch/x86/entry/vdso/extable.o into KASAN, KCSAN, UBSAN, GCOV=
, KCOV
> >  - include arch/x86/entry/vdso/vdso-image-*.o into KASAN, KCSAN, UBSAN,=
 GCOV, KCOV
> >  - include arch/x86/entry/vdso/vdso32-setup.o into KASAN, KCSAN, UBSAN,=
 GCOV, KCOV
> >  - include arch/x86/entry/vdso/vma.o into GCOV, KCOV
> >  - include arch/x86/um/vdso/vma.o into KASAN, GCOV, KCOV
>=20
> I would agree that these cases are all likely desirable.
>=20
> Did you find any cases where you found that instrumentation was _removed_
> where not expected?
>=20
> -Kees
>=20


