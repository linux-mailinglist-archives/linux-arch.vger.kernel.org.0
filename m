Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638B16A6050
	for <lists+linux-arch@lfdr.de>; Tue, 28 Feb 2023 21:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjB1UXc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Feb 2023 15:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjB1UXb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Feb 2023 15:23:31 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E6F30B22;
        Tue, 28 Feb 2023 12:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1677615752; i=deller@gmx.de;
        bh=mMIeglln83RQh/7wRZEKK1o/NLvQ+p7BkhZ5ZuPVbIU=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=cBEe29uFuAf87w1SYnm3RouqwXZ52uB9EL4JqVmnVswWSfJz2ZBc3oVfiVXlOmsZf
         yCpz8KatgjbzL8NnWbgIGTHHG3H1og6MZiGVR0HPExymd2MPKPv+v5ogfjm5TSspHG
         QOzGDrJETybhARUAMnMsYTCfyUctOWPzv9ejLNHpENk1EKMnAsV9G0c+h7BWbFFW0R
         5BLh08hzgNC71BfuNPxlBMIBtNzgyX5o1m5biho/jXMzrHkVVNw0bRABlA0PEqFlvM
         v3QwiCfTkM2fnu0iJY/vr4amYfST/AiIgV994p9JF9I8eRuDq9lOM4llwju0hcv4bd
         jnF8PiguJYevQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([92.116.156.241]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N17Ye-1oUnZK153a-012aKI; Tue, 28
 Feb 2023 21:22:32 +0100
Message-ID: <2646c13f-33b8-1047-7cfe-bf7e394344b6@gmx.de>
Date:   Tue, 28 Feb 2023 21:22:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 08/10] parisc: fix livelock in uaccess
Content-Language: en-US
From:   Helge Deller <deller@gmx.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org
References: <Y9lz6yk113LmC9SI@ZenIV> <Y9l0w4M91DwYLO3N@ZenIV>
 <84b1c2e4-c096-ed19-9701-472b54a4890c@gmx.de> <Y/47PMmpLDX5lPWx@ZenIV>
 <e9972a0e-14e6-987c-fcee-005a50d28e46@gmx.de> <Y/5Sf3fXn0uOUXTw@ZenIV>
 <39436c4d-f5a2-edd5-24ba-19e4812ea364@gmx.de>
 <215b226f-7ffd-70d8-4e7b-85b37f288062@gmx.de>
In-Reply-To: <215b226f-7ffd-70d8-4e7b-85b37f288062@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:m27YsgZtZ8ksJeQxfq1aJIP7UA0lwVViGKacyAWC0goMIGYtCSA
 5OzzU8FcEkdemFIi+VOK7Ux05yk7/kPo0hRMK+78g9H0hNiU1YyQeI9S96Q9lOJn37h/r0/
 WQPDJU2Is2XpH+E0hyjVpT5v3tax1+LMscAxqeijakONn0Nyw2q4q7v7HXWqKCozrFKo9E+
 6zw2uS4d0TPcsTt+I8D8A==
UI-OutboundReport: notjunk:1;M01:P0:UlbeYbijYU8=;47pdr1/iyn9bO5BN1seb4oDWNxl
 mAt0VW2p1/13tHe3OVYXTrE5kbw+euu2riKyf/+W6cFv9+P/c0qGD+w9a0dcS9yk1ZiGi4NBO
 /ajB5pWoqF6LsV1/HPmG2Rkhb9O04k5/IO8dKMLPGJNHbTGYyAWM/4ZgjD/1Moa9J776b3zM+
 ulr5vuE6Ehddxv2CoUrre45fUEQtytEJUTtX1lJ5KvGz848UnCZTtpIAVLVlfvnAdMfVCbEwh
 /loD+lBNF440gr+fhjgr1ZsA5ghGa1sZs5uN1c1vBjKv3U30G/dKaI89ZlWKD80AV8V4xw2sq
 wV95EOV8twE06gFPl0UmzKFNPv0w4x7eHK1guggfJmXrcV1e4s+8RbktJQ48ZHGnp3JERW5V9
 PL52Dq1SAhfmJG38V+Hatvuea6FkPBDkAp5LmqXhfUmWp+tMSFqNnJVCy4lW5g9hxwoWebX3H
 jPMk9VFSMXJaUYf/LtRPVwvv9b0HNkeg52sGFj1YDg7Ix8lgxOAScsYV3l/+iOsI/5+6y8Cnu
 WEFF5UGrNt7d4KB3gXL2UegSkwGzfZVbyWZVXL+UFJ1Qf6GJpVI27x2TKP+M2Q3HGPOs2NXr/
 Smh/gTVdQm2/nRXELGi1iKDmMX3J+y9u1nQzrtxPqdSP3GgPq0zZKDikfQrn+u0CXZrynIrto
 lx/eu4R9Z1yuER5Ewse8+DHjc+cIwJhgQrHjs4SRMj7UV6J3BaFcBp4A0Wzk9Al8QXgiKp4SU
 Syf7itOf+D1crfcU3ITnk5egKnzTKLAfIgh7/u4KgDr2czP/5GvED7O4KOA/phTA89lVS9/aq
 YhzEtguoNHerlGk2QZ+Bk1Z8T3KntotJtqfIRxupqVO81uj0Lu5f2xk/+g2J+vU9WLs3IaZ8O
 prYZKlHb2Dx3JGrzO1Q1vURngPB4kqEyGcmmcHVK0Ku878sKmC5ngA/jM4Gbjv6PaFxMBl+Ct
 0iS9hOM4BxPZzg3s4yBuWTMUyPM=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Al,

On 2/28/23 21:00, Helge Deller wrote:
> On 2/28/23 20:32, Helge Deller wrote:
>> Hi Al,
>>
>> On 2/28/23 20:14, Al Viro wrote:
>>> On Tue, Feb 28, 2023 at 07:26:48PM +0100, Helge Deller wrote:
>>>
>>>> I can test both parisc32 and parisc64.
>>>>
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0Just to confirm: your "can be killed with ^C=
" had been on the
>>>>> mainline parisc kernel (with userfaultfd enable, of course, or it wo=
uldn't
>>>>> hang up at all), right?
>>>>
>>>> It was a recent mainline kernel with your patch.
>>>
>>> Er...=C2=A0 Reproducer *is* supposed to block; the bug is that on the =
kernel
>>> without this patch it would (AFAICS) be impossible to kill - not even
>>> with kill -9.=C2=A0 With bug fixed the behaviour should be "blocks and=
 is
>>> killable", i.e. what you've reported.
>>>
>>> What does it do on unpatched kernel?=C2=A0 *IF* the big is there, it w=
ould
>>> block and be unkillable by any means.=C2=A0 Could you verify that?
>>
>> I just tried 32- and 64-bit kernels.
>> With and without your patch on top of kernel 6.2.
>> The result is always the same:
>> The process hangs, but does not consume CPU and can be killed with ^C o=
r kill command.
>>
>> strace output is:
>>
>> userfaultfd(0)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 =3D 3
>> ioctl(3, UFFDIO_API, {api=3D0xaa, features=3D0 =3D> features=3DUFFD_FEA=
TURE_EVENT_FORK|UFFD_FEATURE_EVENT_REMAP|UFFD_FEATURE_EVENT_REMOVE|UFFD_FE=
ATURE_MISSING_HUGETLBFS|UFFD_FEATURE_MISSING_SHMEM|UFFD_FEATURE_EVENT_UNMA=
P|UFFD_FEATURE_SIGBUS|UFFD_FEATURE_THREAD_ID|0x800, ioctls=3D1<<_UFFDIO_RE=
GISTER|1<<_UFFDIO_UNREGISTER|1<<_UFFDIO_API}) =3D 0
>> ioctl(3, UFFDIO_REGISTER, {range=3D{start=3D0xf7afa000, len=3D0x1000}, =
mode=3DUFFDIO_REGISTER_MODE_MISSING, ioctls=3D1<<_UFFDIO_WAKE|1<<_UFFDIO_C=
OPY|1<<_UFFDIO_ZEROPAGE}) =3D 0
>> fstatfs64(0, 88, {f_type=3DDEVPTS_SUPER_MAGIC, f_bsize=3D4096, f_blocks=
=3D0, f_bfree=3D0, f_bavail=3D0, f_files=3D0, f_ffree=3D0, f_fsid=3D{val=
=3D[0, 0]}, f_namelen=3D255, f_frsize=3D4096, f_flags=3DST_VALID|ST_NOSUID=
|ST_NOEXEC|ST_RELATIME}) =3D 0
>
> Ok, one step further...
>
> We get fooled by glibc, which replaces this line in the testcase:
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D fstatfs(0, (struct s=
tatfs *)mem);
> and instead executes the 64-bit variant fstatfs64() inside a wrapper in =
glibc on another address.
>
> I replaced that line in the testcase to use the 32-bit syscall with the =
right (userfault-specified) address by
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D syscall(__NR_fstatfs=
, 0, mem);
> and now I see:
> userfaultfd(0)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 =3D 3
> ioctl(3, UFFDIO_API, {api=3D0xaa, features=3D0 =3D> features=3DUFFD_FEAT=
URE_EVENT_FORK|UFFD_FEATURE_EVENT_REMAP|UFFD_FEATURE_EVENT_REMOVE|UFFD_FEA=
TURE_MISSING_HUGETLBFS|UFFD_FEATURE_MISSING_SHMEM|UFFD_FEATURE_EVENT_UNMAP=
|UFFD_FEATURE_SIGBUS|UFFD_FEATURE_THREAD_ID|0x800, ioctls=3D1<<_UFFDIO_REG=
ISTER|1<<_UFFDIO_UNREGISTER|1<<_UFFDIO_API}) =3D 0
> ioctl(3, UFFDIO_REGISTER, {range=3D{start=3D0xf7afa000, len=3D0x1000}, m=
ode=3DUFFDIO_REGISTER_MODE_MISSING, ioctls=3D1<<_UFFDIO_WAKE|1<<_UFFDIO_CO=
PY|1<<_UFFDIO_ZEROPAGE}) =3D 0
> fstatfs(0,
> <here it hangs now and is unkillable>
>
> Needs further testing.

Now I can confirm (with the adjusted reproducer), that your patch
allows to kill the process with SIGKILL, while without your patch
it's not possibe to kill the process at all.
I've tested with a 32- and 64-bit parisc kernel.

You may add
Tested-by: Helge Deller <deller@gmx.de> # parisc
to the patch.

If you want me to take the patch (with the warning regarding missing msg v=
ariable fixed)
through the parisc tree, please let me know.

Thank you!
Helge
