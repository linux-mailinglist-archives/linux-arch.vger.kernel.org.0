Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA71107804
	for <lists+linux-arch@lfdr.de>; Fri, 22 Nov 2019 20:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfKVT3o (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Nov 2019 14:29:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59445 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726977AbfKVT3o (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Nov 2019 14:29:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574450982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1SjXyrtPi15bheVyzT1vhDWulX5AkEnn6yZ6MR0YELk=;
        b=AttQLjXV1gS7L/P9IGYHSO0vR2TKLo84btEnwg6Zzd0SUaOAZBjyWGf3CwBd28//4oSZj3
        yvM42XSru7qd3TF4nk0GbNV9IjclNLYYrxwSW3cCz3ykgkzNEOfP/4qye74Zcc+lTki9Q0
        nWBeewztl34GgeZkys7UWOtpljiZZUc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-bT4dcWC7OSWEH6ne-8BOzA-1; Fri, 22 Nov 2019 14:29:38 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E168E107ACC7;
        Fri, 22 Nov 2019 19:29:35 +0000 (UTC)
Received: from llong.remote.csb (ovpn-121-153.rdu2.redhat.com [10.10.121.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EB7EF5C21B;
        Fri, 22 Nov 2019 19:29:32 +0000 (UTC)
Subject: Re: [PATCH v6 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
To:     Alex Kogan <alex.kogan@oracle.com>,
        kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux@armlinux.org.uk,
        peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com, rahul.x.yadav@oracle.com
References: <20191107174622.61718-4-alex.kogan@oracle.com>
 <201911202212.CdyX1gua%lkp@intel.com>
 <B1A1B09F-C44E-45F7-80EB-09E30AEFD358@oracle.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <dc31b3ea-1b03-16d3-1a03-a0a7ad1729d2@redhat.com>
Date:   Fri, 22 Nov 2019 14:29:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <B1A1B09F-C44E-45F7-80EB-09E30AEFD358@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: bT4dcWC7OSWEH6ne-8BOzA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/22/19 1:28 PM, Alex Kogan wrote:
>
>> On Nov 20, 2019, at 10:16 AM, kbuild test robot <lkp@intel.com> wrote:
>>
>> Hi Alex,
>>
>> Thank you for the patch! Yet something to improve:
>>
>> [auto build test ERROR on linus/master]
>> [also build test ERROR on v5.4-rc8 next-20191120]
>> [if your patch is applied to the wrong git tree, please drop us a note t=
o help
>> improve the system. BTW, we also suggest to use '--base' option to speci=
fy the
>> base tree in git format-patch, please see https://urldefense.proofpoint.=
com/v2/url?u=3Dhttps-3A__stackoverflow.com_a_37406982&d=3DDwIBAg&c=3DRoP1Yu=
mCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=3DHvhk3F4omdCk-GE1PTOm3Kn0A7ApWOZ2a=
ZLTuVxFK4k&m=3DBxEt1232ccGlMGDinAB0QAUaTFyl-m5sp4C-crHjpoU&s=3DOzzQqg4fTDV5=
5X-y4vbnGeXoJaPHSvO_EfrUQnMVRHc&e=3D ]
>>
>> url:    https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github.co=
m_0day-2Dci_linux_commits_Alex-2DKogan_locking-2Dqspinlock-2DRename-2Dmcs-2=
Dlock-2Dunlock-2Dmacros-2Dand-2Dmake-2Dthem-2Dmore-2Dgeneric_20191109-2D180=
535&d=3DDwIBAg&c=3DRoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=3DHvhk3F4o=
mdCk-GE1PTOm3Kn0A7ApWOZ2aZLTuVxFK4k&m=3DBxEt1232ccGlMGDinAB0QAUaTFyl-m5sp4C=
-crHjpoU&s=3DuE7ZeYXOFiu09PUVjnCntEe2rR5x_QxS6dEW9twpfok&e=3D=20
>> base:   https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.kerne=
l.org_pub_scm_linux_kernel_git_torvalds_linux.git&d=3DDwIBAg&c=3DRoP1YumCXC=
gaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=3DHvhk3F4omdCk-GE1PTOm3Kn0A7ApWOZ2aZLTu=
VxFK4k&m=3DBxEt1232ccGlMGDinAB0QAUaTFyl-m5sp4C-crHjpoU&s=3DaAKxuXc_c7OF0ffi=
oQfVsIB6H-4Sd9PYxSM7kurm2ig&e=3D  0058b0a506e40d9a2c62015fe92eb64a44d78cd9
>> config: i386-randconfig-f003-20191120 (attached as .config)
>> compiler: gcc-7 (Debian 7.4.0-14) 7.4.0
>> reproduce:
>>        # save the attached .config to linux build tree
>>        make ARCH=3Di386=20
>>
>> If you fix the issue, kindly add following tag
>> Reported-by: kbuild test robot <lkp@intel.com>
>>
>> All error/warnings (new ones prefixed by >>):
>>
>>   In file included from include/linux/export.h:42:0,
>>                    from include/linux/linkage.h:7,
>>                    from include/linux/kernel.h:8,
>>                    from include/linux/list.h:9,
>>                    from include/linux/smp.h:12,
>>                    from kernel/locking/qspinlock.c:16:
>>   kernel/locking/qspinlock_cna.h: In function 'cna_init_nodes':
>>>> include/linux/compiler.h:350:38: error: call to '__compiletime_assert_=
80' declared with attribute error: BUILD_BUG_ON failed: sizeof(struct cna_n=
ode) > sizeof(struct qnode)
>>     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>>                                         ^
>>   include/linux/compiler.h:331:4: note: in definition of macro '__compil=
etime_assert'
>>       prefix ## suffix();    \
>>       ^~~~~~
>>   include/linux/compiler.h:350:2: note: in expansion of macro '_compilet=
ime_assert'
>>     _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>>     ^~~~~~~~~~~~~~~~~~~
>>   include/linux/build_bug.h:39:37: note: in expansion of macro 'compilet=
ime_assert'
>>    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>>                                        ^~~~~~~~~~~~~~~~~~
>>   include/linux/build_bug.h:50:2: note: in expansion of macro 'BUILD_BUG=
_ON_MSG'
>>     BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>>     ^~~~~~~~~~~~~~~~
>>>> kernel/locking/qspinlock_cna.h:80:2: note: in expansion of macro 'BUIL=
D_BUG_ON'
>>     BUILD_BUG_ON(sizeof(struct cna_node) > sizeof(struct qnode));
>>     ^~~~~~~~~~~~
> Consider the following definition of qnode:
>
> struct qnode {
> =09struct mcs_spinlock mcs;
> #if defined(CONFIG_PARAVIRT_SPINLOCKS) || defined(CONFIG_NUMA_AWARE_SPINL=
OCKS)
> =09long reserved[2];
> #endif
> };
>
> and this is how cna_node is defined:
>
> struct cna_node {
> =09struct mcs_spinlock=09mcs;
> =09int=09=09=09numa_node;
> =09u32=09=09=09encoded_tail;
> =09u32=09=09=09pre_scan_result; /* 0, 1, 2 or encoded tail */
> =09u32=09=09=09intra_count;
> };
>
> Since long is 32 bit on i386, we get the compilation error above.
>
> We can try and squeeze CNA-specific fields into 64 bit on i386 (or any 32=
bit=20
> architecture for that matter). Note that an encoded tail pointer requires=
 up=20
> to 24 bits, and we have two of those. We would want different field encod=
ings=20
> for 32 vs 64bit architectures, and this all will be quite ugly.
>
> So instead we should probably either change the definition of @reserved i=
n qnode=20
> to long long, or perhaps disable CNA on 32bit architectures altogether?
> I would certainly prefer the former, especially as it requires the least =
amount=20
> of code/config changes.
>
> Any objections / thoughts?
>
> Thanks,
> =E2=80=94 Alex
>
The easy way out is to restrict NUMA qspinlock to 64-bit only. There
aren't that many 32-bit NUMA systems out there that we have to worry about.

Just add "depends on 64BIT" to the config entry.

Cheers,
Longman


