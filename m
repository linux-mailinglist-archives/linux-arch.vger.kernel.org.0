Return-Path: <linux-arch+bounces-1167-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC6681C9BB
	for <lists+linux-arch@lfdr.de>; Fri, 22 Dec 2023 13:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 275EF281B47
	for <lists+linux-arch@lfdr.de>; Fri, 22 Dec 2023 12:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32AD17993;
	Fri, 22 Dec 2023 12:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="TJ21l5QC"
X-Original-To: linux-arch@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F322617985;
	Fri, 22 Dec 2023 12:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1703247207; x=1703852007; i=deller@gmx.de;
	bh=Sk2Nbe7hUfgjiWyEAvcTOzHJSdWOXOa0Ok9MIPXZ6f0=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=TJ21l5QCkPOCSnnWCDI0E/RDOx9WtSYaK4ohLOHlpyaDKS0QAkO9DD550md9DmM1
	 NrOsDzMntHrBfy7/PBp7rwx7Pbx/qMqwOy+053Yd15X+PfQhTZOV3KdMlRjiE0PBO
	 BKMS6zluOgBA4OIWZrDbbQ6f+gb5sZzd7xPFchdcI4LKN0dsjWsjliLMsjZWo1R5Y
	 bDE2SuzEdGwkwJJgwZUt1wdfMMD/0jf4Mg+NneCmZbYqEMHO1mJibnBNPPtC4Hikg
	 SKG9oALma1SOiRhshn1CS5Eb76gS35D7gVC0iJ4E/eqirRW11d4fSW5hx7Yc5ycxh
	 gPHxECwnXDl/zatreQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.157.108]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M59C8-1rFXwR2Wlo-001EPA; Fri, 22
 Dec 2023 13:13:27 +0100
Message-ID: <1b73bc5a-1948-4e67-9ec5-b238723b3a48@gmx.de>
Date: Fri, 22 Dec 2023 13:13:26 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] modules: Ensure 64-bit alignment on __ksymtab_*
 sections
Content-Language: en-US
To: Luis Chamberlain <mcgrof@kernel.org>, deller@kernel.org
Cc: linux-kernel@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-modules@vger.kernel.org,
 linux-arch@vger.kernel.org
References: <20231122221814.139916-1-deller@kernel.org>
 <20231122221814.139916-3-deller@kernel.org>
 <ZYUlpxlg/WooxGWZ@bombadil.infradead.org>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <ZYUlpxlg/WooxGWZ@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sFTFbdxPRfPDbQUuQ5rZp0TSUkaskdZlblCMM0VVEjiQ81PBPby
 zBTqzyaSuat3ZJCJoRWn+4wGFmuRszk1EDlJZAK6xW20lFKP/G2dUieiGbk6V4mq1LPtDLZ
 hniTJMjxx77vH0tV9OBXkQPZDSh/p0KUkBAVg6sFr3g3zwqfONbdsS0wtMemAG21NQC+Rvi
 bsANedJo3POUo6Xbhb4cA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pXbw2jCV9Lw=;wtG3FpoRGRo8ICR9/3wKHCqSf/i
 5YTB6ltiXelz5bVp2e78CxAJHI7F7i4VOHZLlWpUMAoB3zXlrmeKmeL0ZyuSV3bnAuBiU9oU3
 Op5a1Q6XczY6dpBL2LK/rPG/98NI+UeRJg5c07kJmNtsrN6olgGvT3XMtqMuuk7g0MfkFDLOa
 tNuGbQtQgv87HUK2p2VMjSuO5n5FqQ/uNPpQdGx/tns1NPmVVLJkavGQ4dF8kt0PYHOxwdkmU
 U52ZjejOQNtLYe2rDMLtYIuDDLNS2kpcUU6i4PvDY840yTraUGu80KAhg8eZmLTvBoC15EiO5
 nZsNsO4zywOiK9NHxZCTYWp6x/fm/iPG8Wa7kzRnQ9/Mvww51X6rZ0JX+OzQH4FD2OIeHd+iQ
 fHuvIaAAP10V6fW0yI9ix8q/clRCGTCBi5n+xhyt6MLDs7brwiCDicwOmcDq9CCaAK4Jz2lHV
 jzqwpLzuQNWpR6bWY4497jHKdAd9tuNGAOwgBJNFgMVK4HNpd3v6kNMz05Ybbsq8wsMOG54HN
 PP6Lq/911qM41IppC7JZhd7FmsWskPFG13/wcYXQk/bR/Pgb5omnnBpMNP90/6N1NPy6xHPb7
 bHmboEcIIVG7daGxz/WBrK5JWZIR9FY4fW/NLVaArfz/vlxMERnIGR17MqM+kRC55I+G7BwcU
 7upFG884ryNJiK5IBJCsBGwuT+lk++olhM8sN9T5Uwzy0QTCCiFFWpe2/nbE5hyRxuDwe6eRp
 WIccOh3aPxRgba5ylAH/mWCvuHz1A4QA/7GIaASTX351l8Muw3zy86xJCcH+Bppo7tCTJvOUM
 OEQBcD4uwCmwxoF9L7NtkxB6WAXYhLHo+lCwSDSWYcEuP5gRu/CB2w7h3Q53IdtBDta+mZCEC
 Q6l0DpMed13oyxVobGTdGGbZo43ksn/KtRVT2Nd0LY05TV9M1VuvlbMvV3DMnG+kTfBTlV6ud
 k2OE9w==

Hi Luis,

On 12/22/23 06:59, Luis Chamberlain wrote:
> On Wed, Nov 22, 2023 at 11:18:12PM +0100, deller@kernel.org wrote:
>> From: Helge Deller <deller@gmx.de>
>>
>> On 64-bit architectures without CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
>> (e.g. ppc64, ppc64le, parisc, s390x,...) the __KSYM_REF() macro stores
>> 64-bit pointers into the __ksymtab* sections.
>> Make sure that those sections will be correctly aligned at module link =
time,
>> otherwise unaligned memory accesses may happen at runtime.
>
> The ramifications are not explained there.

What do you mean exactly by this?

> You keep sending me patches with this and we keep doing a nose dive
> on this. It means I have to do more work.
Sorry about that. Since you are mentioned as maintainer for modules I
thought you are the right contact.

Furthermore, this patch is pretty small and trivial.
And I had the impression that people understand that having unaligned
structures is generally a bad idea as it usually always impacts performanc=
e
(although the performance penalty in this case isn't critical at all,
as we are not on hot paths).

> So as I had suggested with your patch which I merged in
> commit 87c482bdfa79 ("modules: Ensure natural alignment for
> .altinstructions and __bug_table sections") please clarify the
> impact of not merging this patch. Also last time you noticed the
> misalignment due to a faulty exception handler, please mention how
> you found this out now.

Sure.

> And since this is not your first patch on the exact related subject
> I'd appreciate if you can show me perf stat results differences between
> having and not having this patch merged. Why? Because we talk about
> a performance penalthy, but we are not saying how much, and since this
> is an ongoing thing, we might as well have a tool belt with ways to
> measure such performance impact to bring clarity and value to this
> and future related patches.
>
>> The __kcrctab* sections store 32-bit entities, so use ALIGN(4) for thos=
e.
>
> I've given some thought about how to test this. Sadly perf kallsysms
> just opens the /proc/kallsysms file, but that's fine, we need our own
> test.
>
> I think a 3 new simple modules selftest would do it and running perf
> stat on it. One module, let us call it module A which constructs its own
> name space prefix for its exported symbols and has tons of silly symbols
> for arbitrary data, whatever. We then have module B which refers to a
> few arbitrary symbols from module A, hopefully spread out linearly, so
> if module A had 10,000 symbols, we'd have module A refer to a symbol
> ever 1,000 symbols. Finally we want a symbol C which has say, 50,000
> symbols all of which will not be used at all by the first two modules,
> but the selftest will load module C first, prior to calling modprobe B.
>
> We'll stress test this way two calls which use find_symbol():
>
> 1) Upon load of B it will trigger simplify_symbols() to look for the
> symbol it uses from the module A with tons of symbols. That's an
> indirect way for us to call resolve_symbol_wait() from module A without
> having to use symbol_get() which want to remove as exported as it is
> just a hack which should go away. Our goal is for us to test
> resolve_symbol() which will call find_symbol() and that will eventually
> look for the symbol on module A with:
>
>    find_exported_symbol_in_section()
>
> That uses bsearch() so a binary search for the symbol and we'd end up
> hitting the misalignments here. Binary search will at worst be O(log(n))
> and so the only way to aggreviate the search will be to add tons of
> symbols to A, and have B use a few of them.
>
> 2) When you load B, userspace will at first load A as depmod will inform
> userspace A goes before B. Upon B's load towards the end right before
> we call module B's init routine we get complete_formation() called on
> the module. That will first check for duplicate symbols with the call
> to verify_exported_symbols(). That is when we'll force iteration on
> module C's insane symbol list.
>
> The selftests just runs
>
> perf stat -e pick-your-poison-for-misalignments tools/testing/selftests/=
kmod/ksymtab.sh
>
> Where ksymtab.sh is your new script which calls:
>
> modprobe C
> modprobe B
>
> I say pick-your-poison-for-misalignments because I am not sure what is
> best here.
>
> Thoughts?

I really appreciate your thoughts here!

But given the triviality of this patch, I personally think you are
proposing a huge academic investment in time and resources with no real be=
nefit.
On which architecture would you suggest to test this?
What would be the effective (really new) outcome?
If the performance penalty is zero or close to zero, will that imply
that such a patch isn't useful?
Please also keep in mind that not everyone gets paid to work on the kernel=
,
so I have neither the time nor the various architectures to test on.

Then, as Masahiro already mentioned, the real solution is
probably to add ".balign" to the various inline assembler parts.
With this the alignment gets recorded in the sh_addralign field
in the object files, and the linker will correctly lay out the executable
even without this patch here.
And, this is exactly what you would get if C-initializers would have
been used instead of inline assembly.

But independend of the correct way to fix it, I think the linker
script ideally should mention all sections it expects with the right
alignments. Just for completeness.

I'll leave it up to you if you will apply this patch.
Currently it's not absolutely needed any longer, but let's think about
the pros/cons of this patch:
Pro:
- It can prevent unnecessary unaligned memory accesses on all arches.
- It provides the linker with correct alignment for the various sections.
- It mimics what you would get if the structs were coded with C-initialize=
rs.
- A correct section alignment can address upcoming inline assembly patches
   which may have missed to add the .balign
Cons:
- For this specific patch the worst case scenario is that we add a total o=
f
   up to 7 bytes to kernel image (__ksymtab gets aligned to 8 bytes and th=
e
   following sections are then already aligned).

So, honestly I don't see a real reason why it shouldn't be applied...

>> Signed-off-by: Helge Deller <deller@gmx.de>
>> Cc: <stable@vger.kernel.org> # v6.0+
>
> That's a stretch without any data, don't you think?

Yes. No need to push such a patch to stable series.

Helge

