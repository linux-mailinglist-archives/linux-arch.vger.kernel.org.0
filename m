Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673716A6013
	for <lists+linux-arch@lfdr.de>; Tue, 28 Feb 2023 21:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjB1UAj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Feb 2023 15:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjB1UAi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Feb 2023 15:00:38 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D539421950;
        Tue, 28 Feb 2023 12:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1677614433; i=deller@gmx.de;
        bh=OuqfJ0Grh06zpWZUN0G//QZhrt4LiSNz5QaJppeqirU=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=C4fOLW1oYqSm6dTJFv1k1vZGdWvlZ/lBW60i6NG1SwyiWUF3xjRLd9TVTiB53M0gD
         zal7iUxH+hXGH83ZL09sLH673DXpcnl0XH+7br+lO6ttZO9HR6r3VRaz4i+zrNFCUP
         0RNl+6z0clZgsS2v0IF2vfxzfFDmTcHZULU6rULcsDchSXWPPIAw90+tR2kWOMy7Mx
         1Xm2pYFM1jqyufiO8v9UcPM9vd7d2VU8/zLDPQ5txoxNaToV1/PdEXPHRMiJ7rOVnk
         nPZonuKQhJSGdgG0jSbaFkI3MXTe7sCqtu3OSOIhM/R2xEOlflWjhPpuk7tqoyU+U0
         7bfxk+Xt9H89g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([92.116.156.241]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWics-1p02X249Um-00X4uu; Tue, 28
 Feb 2023 21:00:33 +0100
Message-ID: <215b226f-7ffd-70d8-4e7b-85b37f288062@gmx.de>
Date:   Tue, 28 Feb 2023 21:00:29 +0100
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
In-Reply-To: <39436c4d-f5a2-edd5-24ba-19e4812ea364@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:n3UzlF3c1ZaxnFoPTlGtu0RngqyirzTbeyekaoP+bWyJZ6xmoSH
 IjP8CjkurdeJBym7Bs91E0xbK0C7zVeQgWbIZINrtnR05lrUptjbfnzxa5An1CIlD2maQF5
 yG6El3BQw9v+pXwb58njiG6iAnyuM0Yv3zvYpjfBqUCOeCQ3pRtIGux8pGVTaWvck3W0Bbf
 qZt8guKTXE5oa43VTTZEQ==
UI-OutboundReport: notjunk:1;M01:P0:fe34G4+zL1k=;yPK+GhYiCWo1Ey9l8vJCxwlCM95
 2mHz0BeV5rZn2ArDu0fPIdWHRuecBnUjM2u/LbRPmVYFBeLjiAv/r5Q8zyqQew6IWXRgH1jwu
 qvuqQovV7q0O/iELzAnrOIHltE7Zo7hKbwbSZX3w97nJO+UXseAhrw9v2A/6ES+9ZTLH8ICWh
 OcCwDkQrMTfPY0YiAVyCLELy2xs/z7V3JYxsuBq1MfXwhOxepYckfRBIZLbljC+1H9PdW//5v
 Xhb5DY4jxdZ77GpZ38CDtdW2aUdXeSTRd0khEQq/yKFi0guS2GLjpbLFLXJgWj+wgxBQVQjxB
 P5frdNBAnzG9Oq0MKgOdFHVx+L3zRKK9vftvdrSDCtsZ1w3C0pQw2BlZufGyixHkfuoScHVvh
 xsv8NYcktk4WtiVwc43hZscTa3OaWrr5taszZiXOQ8gDd9YezfmUr0F1QWmEf9V4Jmzn/cGNd
 UK5hz1Y5neJjog16r+S+O0U9LgRJXbxYpXmf6ZMs697Be6fvuoVOJV+0Dy6NXI4DQ39EYS2lb
 tbP1ZPm6ezu5MPmhX3I1J6jHk3jGflyVFPDPefLIzVAJaHaPyxQWEqid2tyfJQtjV9xoBzGVI
 c7RF/BYJ14E4gcxvDr7J+3rbGXzJsizcJ96t/C2zRc84AsoOCHjfuJxqM0SJXjeR+D4HJ039d
 YtvVH7ZBgHzrD4AR/eOFxO1VQvWTVikEn73/ddAwlQBO3o3YqYvugZH3HimAMvEc9fvxmMnag
 VZ61uPttG2P0nkWbc1slxsYnZTS85j98z+sVvUSa/3cmaqEOPqVWqcvO9A35W7F6ZlqkEpa4B
 pDDWNIKY57isGyFIB6MTKFt7fb5vG8X7e8RL2ESBSh7r8QZ2GA1Dg0FEIw3uLCodfItRFJPZn
 n4HG0WNDwd7arcvorb0eImeHU5KLZoOsGbB9sVuo9h5qxPBrCNAa/oIc+TrJtNOTa3dN8GISa
 rkPZ8Q==
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/28/23 20:32, Helge Deller wrote:
> Hi Al,
>
> On 2/28/23 20:14, Al Viro wrote:
>> On Tue, Feb 28, 2023 at 07:26:48PM +0100, Helge Deller wrote:
>>
>>> I can test both parisc32 and parisc64.
>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0Just to confirm: your "can be killed with ^C"=
 had been on the
>>>> mainline parisc kernel (with userfaultfd enable, of course, or it wou=
ldn't
>>>> hang up at all), right?
>>>
>>> It was a recent mainline kernel with your patch.
>>
>> Er...=C2=A0 Reproducer *is* supposed to block; the bug is that on the k=
ernel
>> without this patch it would (AFAICS) be impossible to kill - not even
>> with kill -9.=C2=A0 With bug fixed the behaviour should be "blocks and =
is
>> killable", i.e. what you've reported.
>>
>> What does it do on unpatched kernel?=C2=A0 *IF* the big is there, it wo=
uld
>> block and be unkillable by any means.=C2=A0 Could you verify that?
>
> I just tried 32- and 64-bit kernels.
> With and without your patch on top of kernel 6.2.
> The result is always the same:
> The process hangs, but does not consume CPU and can be killed with ^C or=
 kill command.
>
> strace output is:
>
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
> fstatfs64(0, 88, {f_type=3DDEVPTS_SUPER_MAGIC, f_bsize=3D4096, f_blocks=
=3D0, f_bfree=3D0, f_bavail=3D0, f_files=3D0, f_ffree=3D0, f_fsid=3D{val=
=3D[0, 0]}, f_namelen=3D255, f_frsize=3D4096, f_flags=3DST_VALID|ST_NOSUID=
|ST_NOEXEC|ST_RELATIME}) =3D 0

Ok, one step further...

We get fooled by glibc, which replaces this line in the testcase:
         ret =3D fstatfs(0, (struct statfs *)mem);
and instead executes the 64-bit variant fstatfs64() inside a wrapper in gl=
ibc on another address.

I replaced that line in the testcase to use the 32-bit syscall with the ri=
ght (userfault-specified) address by
         ret =3D syscall(__NR_fstatfs, 0, mem);
and now I see:
userfaultfd(0)                          =3D 3
ioctl(3, UFFDIO_API, {api=3D0xaa, features=3D0 =3D> features=3DUFFD_FEATUR=
E_EVENT_FORK|UFFD_FEATURE_EVENT_REMAP|UFFD_FEATURE_EVENT_REMOVE|UFFD_FEATU=
RE_MISSING_HUGETLBFS|UFFD_FEATURE_MISSING_SHMEM|UFFD_FEATURE_EVENT_UNMAP|U=
FFD_FEATURE_SIGBUS|UFFD_FEATURE_THREAD_ID|0x800, ioctls=3D1<<_UFFDIO_REGIS=
TER|1<<_UFFDIO_UNREGISTER|1<<_UFFDIO_API}) =3D 0
ioctl(3, UFFDIO_REGISTER, {range=3D{start=3D0xf7afa000, len=3D0x1000}, mod=
e=3DUFFDIO_REGISTER_MODE_MISSING, ioctls=3D1<<_UFFDIO_WAKE|1<<_UFFDIO_COPY=
|1<<_UFFDIO_ZEROPAGE}) =3D 0
fstatfs(0,
<here it hangs now and is unkillable>

Needs further testing.

Helge
