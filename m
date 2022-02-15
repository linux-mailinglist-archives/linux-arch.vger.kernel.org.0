Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510E54B64A4
	for <lists+linux-arch@lfdr.de>; Tue, 15 Feb 2022 08:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234889AbiBOHrq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Feb 2022 02:47:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbiBOHrq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Feb 2022 02:47:46 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD18A8A302;
        Mon, 14 Feb 2022 23:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644911179;
        bh=Gg0eXtIflg4YSdhde6TPBD88ytt9vELXByFDX1EvH5o=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=cL8nOU4P5zROD6QnSaMf+IFH1JNakyChC41kZoyLmoh4OfhoEdCE5EpqWukFvfrr7
         bbAty2PKJpf0Ivg7eDWbBX9KS9Ervz4FISwmJMXSrYDExxKjWqh9fx5gCxmn7+bcB3
         7iZgNWIrcC7CBfK5HN/OAh9s+XgKDV5Ya7JTmsv0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.185.100]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8obG-1oOVrh0Ttm-015uP2; Tue, 15
 Feb 2022 08:46:19 +0100
Message-ID: <215c0ddc-54b1-bcb1-c5aa-bd17c6b100a8@gmx.de>
Date:   Tue, 15 Feb 2022 08:46:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 14/14] uaccess: drop set_fs leftovers
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        will@kernel.org, guoren@kernel.org, bcain@codeaurora.org,
        geert@linux-m68k.org, monstr@monstr.eu, tsbogend@alpha.franken.de,
        nickhu@andestech.com, green.hu@gmail.com, dinguyen@kernel.org,
        shorne@gmail.com, mpe@ellerman.id.au, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com, hca@linux.ibm.com,
        dalias@libc.org, davem@davemloft.net, richard@nod.at,
        x86@kernel.org, jcmvbkbc@gmail.com, ebiederm@xmission.com,
        akpm@linux-foundation.org, ardb@kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        linux-xtensa@linux-xtensa.org
References: <20220214163452.1568807-1-arnd@kernel.org>
 <20220214163452.1568807-15-arnd@kernel.org>
 <YgsYD2nW9GjWJtn5@zeniv-ca.linux.org.uk>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <YgsYD2nW9GjWJtn5@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YbVX8I9McP/aOoptX/QU6xXsMUxj5l3eWtWKIf3O+jL0xku9qtG
 Zvd7JXlVOTeAkMcrw4ura0jf9AQkk5D8MaemK64qHhWPazHfq3pPTRp36Jgwt+Bz560jUXw
 EnyWRjxioFtmKG1I+4nkiaSRoRlQJJpM92uIMgDane+QxlF3STQpbB16Ci0R4wmVz76au1k
 fLV9rswEGC1K4sHhia8eg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NC2D0g2S/Ac=:jSN2OiozPQ2+o13baar10P
 DJFvuJskDJlqwL6taTUNifHjp6CHOCpvH/lM0r8+MeU/IkrDDHBhH7pRYm+9PYQbT3DikuN8Y
 wf2pthhc9JA07KaIYOCZHITmk9asiC4cauJ+KYyIdugvzYTERUeyCi5tklyg6ddqAnY1mFXMN
 IzsYV9Agn4+eqyWx2YPB+vSH14egrQuc/WXYTR5MDXWYgDRkNEUQHagx0PKYbtEOFZOjTpuL2
 mtoM7yAXNS7drjcOzyM19nnxtKwylBBQYcLPkj218FbcLL2vzhJHiHAWd24/Q9W3s09nHCIE6
 fGumtyqCsMeSqw0mMH4wo+GvEWCCG6H4FoL+qDBFD2sodlwN+X7gfqBSW11rLH+XM3x8YM8NN
 J54e3TA+Vei8jw4LRGe9Ymmqhkiqk6Uc6Wko0CB9iTVPAtnltjRfoYslftpQXOaFdBUYl2aok
 k0g9BBm17D0XENQhlxsLa+WnayrWKt6yhyp1M7UGChhokjicHtvLAIy7ZtiZebwac9KgVxHVd
 AQSmSlQgCo0OBFalh6iMSakk2BLgIjbIZKPGF2lt07iBIKj3hrvythTjqM9Kx9g4Mb9yKKUiR
 3hX3nB3W5yrzrvjAHjmMzLC5EmkRc15EoGpyfTlWnxkgto9eQnU+aUViFusixT5EpyIl2ug8Q
 H4Kk+m6f3GVxVKL2Cx0ClZdpN0Zw+GeYYd7Pke8Y8nEMm549lY9iGBFHXyCw8F2oNiBZVz/4+
 r1+Nz55zL4OErT4gqcqQim8TkBXvrLFJFeMF9Rs2Sr1cbQ0e8NM+TnoZSBjb2f9bWY8kh7F1o
 qu/V8M1FYX5b55nnwZEcROdmSlyYYHcymV+Yhds+gLhP/FS7CDLGp9IQz74c+WtjVrbg1a9ol
 wtrU5pIjiq/IBVYjCGlvJkUiX5qyYdvO48Ut1Tm1RMknPly6TVv5RW4v9ku8Y61mAR2Xi+BzF
 wgnYdYR+Vn0Nzr7bHUXkOqVZlT4a138K2E/bPk4wyFt6d5rh0A1e53c9E5+hNVMfoUb38M8eC
 IpYPs2Cvw5bMlKnUT33aNolZnoMt9Z+67iy8yZqI7/YHnt36EIgrIQMWOt9AaL+QmqLMHPGxA
 Krl57Lr0WyEtCA=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/15/22 04:03, Al Viro wrote:
> On Mon, Feb 14, 2022 at 05:34:52PM +0100, Arnd Bergmann wrote:
>> diff --git a/arch/parisc/include/asm/futex.h b/arch/parisc/include/asm/=
futex.h
>> index b5835325d44b..2f4a1b1ef387 100644
>> --- a/arch/parisc/include/asm/futex.h
>> +++ b/arch/parisc/include/asm/futex.h
>> @@ -99,7 +99,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *=
uaddr,
>>  	/* futex.c wants to do a cmpxchg_inatomic on kernel NULL, which is
>>  	 * our gateway page, and causes no end of trouble...
>>  	 */
>> -	if (uaccess_kernel() && !uaddr)
>> +	if (!uaddr)
>>  		return -EFAULT;
>
> 	Huh?  uaccess_kernel() is removed since it becomes always false now,
> so this looks odd.
>
> 	AFAICS, the comment above that check refers to futex_detect_cmpxchg()
> -> cmpxchg_futex_value_locked() -> futex_atomic_cmpxchg_inatomic() call =
chain.
> Which had been gone since commit 3297481d688a (futex: Remove futex_cmpxc=
hg
> detection).  The comment *and* the check should've been killed off back
> then.
> 	Let's make sure to get both now...

Right. Arnd, can you drop this if() and the comment above it?

Thanks,
Helge
