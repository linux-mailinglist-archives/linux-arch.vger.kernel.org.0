Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0534B89DF
	for <lists+linux-arch@lfdr.de>; Wed, 16 Feb 2022 14:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbiBPN2o (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Feb 2022 08:28:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiBPN2n (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Feb 2022 08:28:43 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB43151D3E;
        Wed, 16 Feb 2022 05:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645018096;
        bh=HwNrev1x9N/bAHozCMnHh0/SWdmQxawrVLg0m+YakW0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=RUtWJPgj02d9RdJYQ7YoSVHPNgdJKkbQLGxH/3959fWlRoxCzs+SEUv8MhF9EIuSd
         UPOms99OagbeNHn9T2GREA/Kzg1CItzhmNQ9p1MZePz84ZabXDt6BIzIIZkLX4OEiL
         umm0oSmyex5vNBSnWFCgn2yRL7eID38JcE3sRZpk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.128.232]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MlNtF-1nz7c511Rd-00lnUS; Wed, 16
 Feb 2022 14:28:16 +0100
Message-ID: <7c557d0c-6718-4e16-29c6-8b75c704b773@gmx.de>
Date:   Wed, 16 Feb 2022 14:26:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 00/13] Fix LKDTM for PPC64/IA64/PARISC v4
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
References: <cover.1644928018.git.christophe.leroy@csgroup.eu>
 <202202150807.D584917D34@keescook>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <202202150807.D584917D34@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7WUZ8IdPRgrLzg2kYAsCubjhcGSsfWfnDerK+e6MsDTo0WVtSo1
 Qo1CSZAO42swRuv6lToQn2mbsuQy/pB029PlMs3UDpE+ADYKs4fY8RkSq6zythe/H0UD0qp
 PJiEhm1bu11UqjwgQDhFNERLa6KstnkZlTWu4pgSqsVGe95043DiptKYmRvLXMi+S5ig2G7
 A9mnu9SU2Bsce/RvmK/YQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HQlDLvllLB4=:zG9VjdQRhRW5zMKE35JAvQ
 sTaBZEmtmI9M5ryeCAdLypOUp+VWPjwhleh58s4Bx0MfvSQfMtggCwUjcI0R8FJVGQcyqOZIs
 gqHhsqvhwutFDRldf6md8zmmGtk6TwaVyquzZ1MCESW2SrE6zcGTymzFpltWz+Rdkdm1YFzoa
 lhTa5F+9uqsO8bDVGoqGaDUIiyihY5hNJSxdBLYV4ERtbrvekgcL3XZjnnhPOTyNx8JQ28Yjp
 4fK2TTtL0ghtJ4mnEmXuu4xsl/+m2AaqMf5GyF2X+Gss44eGD/xxCgtYJBPRBw4FbPSnQiUXK
 ESp0mlJlpOtqulWHrEWJSxblPFaZMQF80liBI30esPGycROuavhe7HL9FL0IPQjGywvwrnUQB
 YK+pU/QiiMlEJYmZdHT4tV65PWHI4/4wFVfWyEHguIml8zPF+yrR4FQ2LPLOEElJj2ZXmP1Il
 ptIbyziXpMsIbCltb1QduqrC2jpL8QzlTmh0AO3SaXvAkH12v5CYNAIjLx8CJ7BOOuQlzFA3b
 5EF70bAPJl1RszsfR54ncea2HR/kjLjsEjAAnlAyOPytQAbaWqQnzaoirFM9KCpaxCytx71Pk
 0Bb+Cvv81aE5/W0KggKYi9IITAtuxBRxtjjoHnTv0CuPXBKjqr8o7rKDbWNaeOBjVtsAXTBIE
 nfQiRXLcflgKsnrIhrvnwElHTrj4HOnt39TJRk7y3MuTYdx++/uvDNrsBEi4Sm8QW0ZPUCWWC
 5d0WWIxb+B84bK4DfWOp7hVVSl/WYpgWqH5b4hU2WVpaBhs3zjSNoE03rlVfqj8Plm/0XcYMn
 HKbc0j0eIXagEdOr/A8UnONn6xvHzDG6IlK86sNVMaW6miOMxkiqDf4AXt3RcD60mUBOpxWh6
 hovUfJj4ODRTGQeG6EIMT9I2fWf/qBJtPssP+L6yma1zYEBPucaJAUDCNTf14W8tDovm0ErnO
 U31rrGLF8j6wf/UYsXTNfyVbf6s0842T9tNF8uum82B211/ALU5kr2q7fOpyto8A6IZl1VN8I
 U/XrzPQALxcWCHwdRPHpc7x1H1HZuNVH/zyWx8sChgHXxjHJl2Os5vV4IHwWbTE/HLT+foop1
 IGBNEhLpIEk+tI=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/15/22 17:07, Kees Cook wrote:
> On Tue, Feb 15, 2022 at 01:40:55PM +0100, Christophe Leroy wrote:
>> PPC64/IA64/PARISC have function descriptors. LKDTM doesn't work
>> on those three architectures because LKDTM messes up function
>> descriptors with functions.
>>
>> This series does some cleanup in the three architectures and
>> refactors function descriptors so that it can then easily use it
>> in a generic way in LKDTM.
>
> Thanks for doing this! It looks good to me. :)

I endorse that.
Thank you, Christophe!

Acked-by: Helge Deller <deller@gmx.de>

Helge

> -Kees
>
>>
>> Changes in v4:
>> - Added patch 1 which Fixes 'sparse' for powerpc64le after wrong report=
 on previous series, refer https://github.com/ruscur/linux-ci/actions/runs=
/1351427671
>> - Exported dereference_function_descriptor() to modules
>> - Addressed other received comments
>> - Rebased on latest powerpc/next (5a72345e6a78120368fcc841b570331b6c5a5=
0da)
>>
>> Changes in v3:
>> - Addressed received comments
>> - Swapped some of the powerpc patches to keep func_descr_t renamed as s=
truct func_desc and remove 'struct ppc64_opd_entry'
>> - Changed HAVE_FUNCTION_DESCRIPTORS macro to a config item CONFIG_HAVE_=
FUNCTION_DESCRIPTORS
>> - Dropped patch 11 ("Fix lkdtm_EXEC_RODATA()")
>>
>> Changes in v2:
>> - Addressed received comments
>> - Moved dereference_[kernel]_function_descriptor() out of line
>> - Added patches to remove func_descr_t and func_desc_t in powerpc
>> - Using func_desc_t instead of funct_descr_t
>> - Renamed HAVE_DEREFERENCE_FUNCTION_DESCRIPTOR to HAVE_FUNCTION_DESCRIP=
TORS
>> - Added a new lkdtm test to check protection of function descriptors
>>
>> Christophe Leroy (13):
>>   powerpc: Fix 'sparse' checking on PPC64le
>>   powerpc: Move and rename func_descr_t
>>   powerpc: Use 'struct func_desc' instead of 'struct ppc64_opd_entry'
>>   powerpc: Remove 'struct ppc64_opd_entry'
>>   powerpc: Prepare func_desc_t for refactorisation
>>   ia64: Rename 'ip' to 'addr' in 'struct fdesc'
>>   asm-generic: Define CONFIG_HAVE_FUNCTION_DESCRIPTORS
>>   asm-generic: Define 'func_desc_t' to commonly describe function
>>     descriptors
>>   asm-generic: Refactor dereference_[kernel]_function_descriptor()
>>   lkdtm: Force do_nothing() out of line
>>   lkdtm: Really write into kernel text in WRITE_KERN
>>   lkdtm: Fix execute_[user]_location()
>>   lkdtm: Add a test for function descriptors protection
>>
>>  arch/Kconfig                             |  3 +
>>  arch/ia64/Kconfig                        |  1 +
>>  arch/ia64/include/asm/elf.h              |  2 +-
>>  arch/ia64/include/asm/sections.h         | 24 +-------
>>  arch/ia64/kernel/module.c                |  6 +-
>>  arch/parisc/Kconfig                      |  1 +
>>  arch/parisc/include/asm/sections.h       | 16 ++----
>>  arch/parisc/kernel/process.c             | 21 -------
>>  arch/powerpc/Kconfig                     |  1 +
>>  arch/powerpc/Makefile                    |  2 +-
>>  arch/powerpc/include/asm/code-patching.h |  2 +-
>>  arch/powerpc/include/asm/elf.h           |  6 ++
>>  arch/powerpc/include/asm/sections.h      | 29 ++--------
>>  arch/powerpc/include/asm/types.h         |  6 --
>>  arch/powerpc/include/uapi/asm/elf.h      |  8 ---
>>  arch/powerpc/kernel/module_64.c          | 42 ++++++--------
>>  arch/powerpc/kernel/ptrace/ptrace.c      |  6 ++
>>  arch/powerpc/kernel/signal_64.c          |  8 +--
>>  drivers/misc/lkdtm/core.c                |  1 +
>>  drivers/misc/lkdtm/lkdtm.h               |  1 +
>>  drivers/misc/lkdtm/perms.c               | 71 +++++++++++++++++++-----
>>  include/asm-generic/sections.h           | 15 ++++-
>>  include/linux/kallsyms.h                 |  2 +-
>>  kernel/extable.c                         | 24 +++++++-
>>  tools/testing/selftests/lkdtm/tests.txt  |  1 +
>>  25 files changed, 155 insertions(+), 144 deletions(-)
>>
>> --
>> 2.34.1
>>
>

