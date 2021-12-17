Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC38479281
	for <lists+linux-arch@lfdr.de>; Fri, 17 Dec 2021 18:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239674AbhLQRMq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Dec 2021 12:12:46 -0500
Received: from mout.gmx.net ([212.227.15.18]:43203 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239675AbhLQRMp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 17 Dec 2021 12:12:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1639761149;
        bh=nTwjJ/cnuT0Typyl6+FFGgb6cw8PUp2Hhdq7Dxmubh0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=lykRjIGV1WZ4x1rUUW1JP9Q+AVEhoaNcZId8Xz4gVZnXbJTa8yRl8wie7jYiZ638y
         dlH2hW+G/1MxaHlAQJCiExujeRGXt1euORu6VTwApA1uJRwhxvljqJr3+It+T81ihR
         i1lzXA1zjpQAyGilujChARH640I0PhgT2rQR29Ig=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.181.24]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPXd2-1nBy8t2stu-00MapY; Fri, 17
 Dec 2021 18:12:29 +0100
Message-ID: <295e2386-eda8-a9d8-3748-60f48205a815@gmx.de>
Date:   Fri, 17 Dec 2021 18:12:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v3 11/12] lkdtm: Fix execute_[user]_location()
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Kees Cook <keescook@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Paul Mackerras <paulus@samba.org>,
        Arnd Bergmann <arnd@arndb.de>
References: <cover.1634457599.git.christophe.leroy@csgroup.eu>
 <d4688c2af08dda706d3b6786ae5ec5a74e6171f1.1634457599.git.christophe.leroy@csgroup.eu>
 <e7793192-6879-490d-1f37-3d6d6908a121@csgroup.eu>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <e7793192-6879-490d-1f37-3d6d6908a121@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:t39+qgQtUdFYhLWaR4ktFZpw2IGTCWRMsa8sbAkTDnzeLkkp4HT
 FG3itWE0wReh8ICjXvNXQqBVvWU8r9tHp74/IvFzsj3pQKsdbmv5IVZFgPMGs1V+ynIicFL
 S1NXCiSVkystwXxmUcf422y8pBCACWrFUu6Ju5WSOvH+2M7s30bAyU3Or/idGaJubajv3pa
 LqJFVrkPjs7P44jc25gnQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:sphp7f4HiA4=:RFQYrMUnJl770ORGTHOd3x
 4AhdwQpuV/Jb6WLYV74GPqymlKonWTF4A4XA7VljZdm32iMWrqgP0aZfIZzBr99TSX4Fj6ZQ3
 Xt5Xqywk5Z0x0zJnX7p0i/WNuy714W3aJDZlWZaATcgRQ2qQvaeRASX1kuY0dcGgEAqz65LWw
 H9KpKEfkax0kzKB9+npQ0NA/WKigs4A0eadclz0p2fO64DBHoD41LDqYNPKxvgVSkRBc3U3+I
 HHRAOm2K9rOgcznvNeNAfFMgV+noGvJ9jD3xW04AcHOdNU3ftKp5s2lcNUG9nG8md2UQQWiD8
 f0zRXniz2dnGu3149SCccXg0aSuc3r1JuZdqWX8bAYo0wzfPdflOEDsrS2GuuaZ00d7bmPqDf
 VJYiLpJr8iu5Be7JeXGF5vo0SXCy4tqC/huk7YIVq1fLl/BF7OC3i02I2y4pnb03DEXPhWCXP
 bSDVKvzUVnn+mXMt3UkQ/Op90KorOtedRL7VJpiCdHv5xTT+wYQA7WTQ2VDRUX3CaqolHLrBe
 /ip1P1LbcspP74KR2srEzj/5xW3LYoXiunEsRRmKz0Dnnjn1epW0Ba9UdQ25DTt9EaqgN686H
 RTfBHI6F8KxLlE/JTa8B+vC+MRPSdMNuojqB04xPNBL4c+kYIdVZhwZh3WbQE1TVKu7gLG4wl
 lLnD+MwZEE7AZhegL4vKyQy+1NOCdtu1vg0OGkIEO3ppZJjov6GvKWfDgwxsSFrbmaXBJwbpK
 vEZVMrvAhqrqfpICCKitouq67tvrfkcrheN1NeCmgAjapTACz1rWakP1Ceo2IMTZ325F0ItXz
 oIxntJkSFGoW8CCWzjBNyUkPvkKGFBgKRm+LH2jW0zUkKWdlzAP1it06+6FCHEUF6Y194og6a
 ZsgxSlnM+Ad/qNxMV+ZpnO+Uco8bysc7MGaaoybrtgKWHWhQue6ZhDZX/5lIDJrUpf+AB743A
 63/IXKaCO0EWpdsxwQis4A2sK5fH4Tt6amvD56lTUEKfZzvxI1GmSd4P5SRR2iMtSChCW4aGz
 cwUg1KUOGBBP11YtwZg31QxwcPF6WmqDwwhmbHbuHPU+BWhEnqv/baVfp0YhbhRDhtLyNtY7R
 yNphjEqau1iVOY=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 12/17/21 12:49, Christophe Leroy wrote:
> Hi Kees,
>
> Le 17/10/2021 =C3=A0 14:38, Christophe Leroy a =C3=A9crit=C2=A0:
>> execute_location() and execute_user_location() intent
>> to copy do_nothing() text and execute it at a new location.
>> However, at the time being it doesn't copy do_nothing() function
>> but do_nothing() function descriptor which still points to the
>> original text. So at the end it still executes do_nothing() at
>> its original location allthough using a copied function descriptor.
>>
>> So, fix that by really copying do_nothing() text and build a new
>> function descriptor by copying do_nothing() function descriptor and
>> updating the target address with the new location.
>>
>> Also fix the displayed addresses by dereferencing do_nothing()
>> function descriptor.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>
> Do you have any comment to this patch and to patch 12 ?
>
> If not, is it ok to get your acked-by ?


Hi Christophe,

I think this whole series is a nice cleanup and harmonization
of how function descriptors are used.

At least for the PA-RISC parts you may add:
Acked-by: Helge Deller <deller@gmx.de>

Thanks!
Helge

>
>> ---
>>   drivers/misc/lkdtm/perms.c | 37 ++++++++++++++++++++++++++++---------
>>   1 file changed, 28 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
>> index 035fcca441f0..1cf24c4a79e9 100644
>> --- a/drivers/misc/lkdtm/perms.c
>> +++ b/drivers/misc/lkdtm/perms.c
>> @@ -44,19 +44,34 @@ static noinline void do_overwritten(void)
>>   	return;
>>   }
>>
>> +static void *setup_function_descriptor(func_desc_t *fdesc, void *dst)
>> +{
>> +	if (!have_function_descriptors())
>> +		return dst;
>> +
>> +	memcpy(fdesc, do_nothing, sizeof(*fdesc));
>> +	fdesc->addr =3D (unsigned long)dst;
>> +	barrier();
>> +
>> +	return fdesc;
>> +}
>> +
>>   static noinline void execute_location(void *dst, bool write)
>>   {
>> -	void (*func)(void) =3D dst;
>> +	void (*func)(void);
>> +	func_desc_t fdesc;
>> +	void *do_nothing_text =3D dereference_function_descriptor(do_nothing)=
;
>>
>> -	pr_info("attempting ok execution at %px\n", do_nothing);
>> +	pr_info("attempting ok execution at %px\n", do_nothing_text);
>>   	do_nothing();
>>
>>   	if (write =3D=3D CODE_WRITE) {
>> -		memcpy(dst, do_nothing, EXEC_SIZE);
>> +		memcpy(dst, do_nothing_text, EXEC_SIZE);
>>   		flush_icache_range((unsigned long)dst,
>>   				   (unsigned long)dst + EXEC_SIZE);
>>   	}
>> -	pr_info("attempting bad execution at %px\n", func);
>> +	pr_info("attempting bad execution at %px\n", dst);
>> +	func =3D setup_function_descriptor(&fdesc, dst);
>>   	func();
>>   	pr_err("FAIL: func returned\n");
>>   }
>> @@ -66,16 +81,19 @@ static void execute_user_location(void *dst)
>>   	int copied;
>>
>>   	/* Intentionally crossing kernel/user memory boundary. */
>> -	void (*func)(void) =3D dst;
>> +	void (*func)(void);
>> +	func_desc_t fdesc;
>> +	void *do_nothing_text =3D dereference_function_descriptor(do_nothing)=
;
>>
>> -	pr_info("attempting ok execution at %px\n", do_nothing);
>> +	pr_info("attempting ok execution at %px\n", do_nothing_text);
>>   	do_nothing();
>>
>> -	copied =3D access_process_vm(current, (unsigned long)dst, do_nothing,
>> +	copied =3D access_process_vm(current, (unsigned long)dst, do_nothing_=
text,
>>   				   EXEC_SIZE, FOLL_WRITE);
>>   	if (copied < EXEC_SIZE)
>>   		return;
>> -	pr_info("attempting bad execution at %px\n", func);
>> +	pr_info("attempting bad execution at %px\n", dst);
>> +	func =3D setup_function_descriptor(&fdesc, dst);
>>   	func();
>>   	pr_err("FAIL: func returned\n");
>>   }
>> @@ -153,7 +171,8 @@ void lkdtm_EXEC_VMALLOC(void)
>>
>>   void lkdtm_EXEC_RODATA(void)
>>   {
>> -	execute_location(lkdtm_rodata_do_nothing, CODE_AS_IS);
>> +	execute_location(dereference_function_descriptor(lkdtm_rodata_do_noth=
ing),
>> +			 CODE_AS_IS);
>>   }
>>
>>   void lkdtm_EXEC_USERSPACE(void)

