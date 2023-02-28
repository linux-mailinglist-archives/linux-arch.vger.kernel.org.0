Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1916C6A5FB2
	for <lists+linux-arch@lfdr.de>; Tue, 28 Feb 2023 20:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjB1Tca (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Feb 2023 14:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjB1TcZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Feb 2023 14:32:25 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4498B32E6B;
        Tue, 28 Feb 2023 11:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1677612741; i=deller@gmx.de;
        bh=UMPdP0o5n1hmZaa30ULdZS6SG90EzSmHAUWQzS2bozc=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=t58CZKjQrnJUlj3vNjcwcDNSGzdaiBAjQHlZAVhaNK8+4399tpzkgId066I95u7cn
         cVue6vY3L1Y2xYq1DSBpBO+C9KUUHwzdaUAJSXDBQrHfnO09lH8ya3oA5MXw6yirEq
         RrFehd7vhXZRDqtHt7+KQF4b3ckCj8yk1f23SSzsblnlV/UDIgw69KGAfrJqF/AUcE
         vSO6rl8HALnGQJmdWPUuY0NSJVuDxVStnOWiW00RpkVmsiuDxJwmaoBBkpemkcU22X
         Cvh2eISEvpMbRRc0yVWZ+7YtIJB4IYRUFrNTJ2wNWHkrpMj+URLT0+l0QQe1DCl7uk
         1MiIN2vj/dXOg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([92.116.156.241]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHGCo-1pJuRJ16Cu-00DCm1; Tue, 28
 Feb 2023 20:32:21 +0100
Message-ID: <39436c4d-f5a2-edd5-24ba-19e4812ea364@gmx.de>
Date:   Tue, 28 Feb 2023 20:32:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 08/10] parisc: fix livelock in uaccess
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org
References: <Y9lz6yk113LmC9SI@ZenIV> <Y9l0w4M91DwYLO3N@ZenIV>
 <84b1c2e4-c096-ed19-9701-472b54a4890c@gmx.de> <Y/47PMmpLDX5lPWx@ZenIV>
 <e9972a0e-14e6-987c-fcee-005a50d28e46@gmx.de> <Y/5Sf3fXn0uOUXTw@ZenIV>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <Y/5Sf3fXn0uOUXTw@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:udzRmkNYc+ivgfLFFhKl4l+VqVXJtbOa0Ocgo0OrssbP17bn8Fg
 Pi8xl0hRJeMHvba0pJzCViq+tINElklaiUK1UzCdJg6Aym//VkZp3yu+W7JIpZ5Xy4Pozri
 JYM1M66ewbJFEApUEWaSGNG4sUHjd2q/xbepJnOe3cnDRb14YZ05d5ob68e5UYFcoRnmxs6
 femddELjCgL3s9AvaYOSQ==
UI-OutboundReport: notjunk:1;M01:P0:ql3g5MSOeEQ=;u9DFMqm3ZobOtFNUDKlt85qpxbW
 chG6CLDuZNJbgghE5ZmgSmIc3/LY3bFHsdysnbrMcCBM1gh08kAnElxQ8OPjpHve74oNCk7Qp
 R4lksBFCqMwSGrama3osJEWw6GjgX6L+NBYTG5qbTLKpjMIHD/d714DZPw+g2+B7d28AxsbeG
 WRm/RAfbL3xZD8JR6LLyF/gI2YGCw3ap21rJGyfsVOC3d5DU+lDuB6MeWR5R9vJ6LVfAWUm3M
 1C+7G68JCDn0fiS7clvLcz22LmWsxBB738wdOLkSUPoYN6IT64UeAdqQIN4HW6TIOH4flcqbL
 eklTw02Qxt2kvT7nd9+6b/g8lXekRGCzJr0h2eRzfos9StSnMFiYr4P7L6CMlnV76UtHnym/A
 Dmtcy3nCKhTiVOQS1rsME+WjBDi0qbcCtCgZaBDLN6JcrdrKwXt85fgrl0Ruvr6Erej1jU6M6
 8UNHnz7JmwuDL1+r65MeXgVJntrGgVwVHlaCj90ugWy3f8Q7jMR+r1prpKTKOnBqEJjoCuAM4
 b8ieZmE8qKwIQzM9oI6eP6m7FNG7Xl22pWeja+TOzTINcZ1T+ILHUJ8gAm6RM6zFzqbWQZZQg
 Bqc5+sf+6h9rXX3mb0g7Z7NmIVHPw4/HFc+z7cXJX4YhvPuQBetDZNPm0xpobZLSDTXPL6Gi2
 b68VV2mM/w4LAYp/ohHq4fzj5pAx+6oSjDwt4mVOxEbqmmh/FZskOCDr3x5sUvlqFvIsFKnup
 zaJXNIobCExU+uAnRtxA1yhT6eXtryQbI3McZLqaFxmQR4YVfBVX2ZdOq0hi6fwGXiviV9fM8
 YfFRPGgOS2FIUONV4F+TgbIO6zaQtsUegR6ZpbjahIaeRREucQgiEGygYz3h53Pc0emft3gj9
 dy99wLnlb7PLlgqCrSc5n1Xbxip5UlH884LzayzlMFza0cOi6Jjz/nAnUYz55DEHn1Jq9erob
 Q5G7vg==
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

On 2/28/23 20:14, Al Viro wrote:
> On Tue, Feb 28, 2023 at 07:26:48PM +0100, Helge Deller wrote:
>
>> I can test both parisc32 and parisc64.
>>
>>> 	Just to confirm: your "can be killed with ^C" had been on the
>>> mainline parisc kernel (with userfaultfd enable, of course, or it woul=
dn't
>>> hang up at all), right?
>>
>> It was a recent mainline kernel with your patch.
>
> Er...  Reproducer *is* supposed to block; the bug is that on the kernel
> without this patch it would (AFAICS) be impossible to kill - not even
> with kill -9.  With bug fixed the behaviour should be "blocks and is
> killable", i.e. what you've reported.
>
> What does it do on unpatched kernel?  *IF* the big is there, it would
> block and be unkillable by any means.  Could you verify that?

I just tried 32- and 64-bit kernels.
With and without your patch on top of kernel 6.2.
The result is always the same:
The process hangs, but does not consume CPU and can be killed with ^C or k=
ill command.

strace output is:

userfaultfd(0)                          =3D 3
ioctl(3, UFFDIO_API, {api=3D0xaa, features=3D0 =3D> features=3DUFFD_FEATUR=
E_EVENT_FORK|UFFD_FEATURE_EVENT_REMAP|UFFD_FEATURE_EVENT_REMOVE|UFFD_FEATU=
RE_MISSING_HUGETLBFS|UFFD_FEATURE_MISSING_SHMEM|UFFD_FEATURE_EVENT_UNMAP|U=
FFD_FEATURE_SIGBUS|UFFD_FEATURE_THREAD_ID|0x800, ioctls=3D1<<_UFFDIO_REGIS=
TER|1<<_UFFDIO_UNREGISTER|1<<_UFFDIO_API}) =3D 0
ioctl(3, UFFDIO_REGISTER, {range=3D{start=3D0xf7afa000, len=3D0x1000}, mod=
e=3DUFFDIO_REGISTER_MODE_MISSING, ioctls=3D1<<_UFFDIO_WAKE|1<<_UFFDIO_COPY=
|1<<_UFFDIO_ZEROPAGE}) =3D 0
fstatfs64(0, 88, {f_type=3DDEVPTS_SUPER_MAGIC, f_bsize=3D4096, f_blocks=3D=
0, f_bfree=3D0, f_bavail=3D0, f_files=3D0, f_ffree=3D0, f_fsid=3D{val=3D[0=
, 0]}, f_namelen=3D255, f_frsize=3D4096, f_flags=3DST_VALID|ST_NOSUID|ST_N=
OEXEC|ST_RELATIME}) =3D 0

<here it hangs until I kill the process with SIGTERM>

=2D-- SIGTERM {si_signo=3DSIGTERM, si_code=3DSI_USER, si_pid=3D859, si_uid=
=3D0} ---
+++ killed by SIGTERM +++
Terminated

It seems the code flow doesn't reaches fault_signal_pending(), or it retur=
ns false...

Helge
