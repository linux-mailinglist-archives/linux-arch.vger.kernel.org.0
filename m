Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B38CA6B045
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jul 2019 22:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbfGPUOM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Jul 2019 16:14:12 -0400
Received: from mout.gmx.net ([212.227.15.19]:36299 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728137AbfGPUOL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 16 Jul 2019 16:14:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1563308042;
        bh=7VY8YH9jMovACrIdrhvISc8JByEG9+fowfzeNmRgOfo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Kw1mKomLyf4TbBJ/zg23P7apFrDxlIIFzSokOMo69AtSxElmYEy4eq2eopppd7wMr
         V8XRtNTIUYn4ltq5K91JC1v/XK7U38Oklx26zHYJGCDzpAqlGcHoZIBzBhosfArtWz
         QREVdI+1aykJHs0N3A/CQ2T+LAPEzD202Z7jEasM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.163.176]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MkHMZ-1iC4Dg3Ysb-00kbu2; Tue, 16
 Jul 2019 22:14:01 +0200
Subject: Re: [PATCH 1/2] arch: mark syscall number 435 reserved for clone3
To:     Christian Brauner <christian@brauner.io>,
        Sven Schnelle <svens@stackframe.org>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>, mpe@ellerman.id.au
References: <20190714192205.27190-1-christian@brauner.io>
 <20190714192205.27190-2-christian@brauner.io>
 <e14eb2f9-43cb-0b9d-dec4-b7e7dcd62091@de.ibm.com>
 <20190716130631.tohj4ub54md25dys@brauner.io>
 <20190716185310.GA12537@t470p.stackframe.org>
 <20190716185554.gwpppirvmxgvnkgb@brauner.io>
From:   Helge Deller <deller@gmx.de>
Message-ID: <6d47935e-218c-3eb9-7617-14ce199f5958@gmx.de>
Date:   Tue, 16 Jul 2019 22:13:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190716185554.gwpppirvmxgvnkgb@brauner.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2cW2yydYOFZ0K7SnlkSJRJZL6gbN19kSgKbyZFedY35qUSBwLwc
 KFwmZoyiIfN7b/p+DVlTRhgAyhZ7VdGpXdQVEnj51qjaJkW5gaAkDBU8LIwUGMGXiMX9maV
 GUvBYvRjVz9REkKhNe849boNzNZvi79Q2Q2BRRVgSNGmQF+a0pftaHPMxwZ9+pCndGXBx6X
 LsecZ2wqaeXWgof6fVzqg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4Ns/Ko0qGwY=:qtFJO0B/HPz+a+JhQFRjzt
 ZUmBSoerPrHropq5sAotY7F8GaBnQ0NKeQ9hZL+YtLcMAI3L6BI6rfq0NI6MgK1ZvAJLCivvK
 NUgYMbGygYMSZU1miPsKEwZe124zRrnQ4jnIE+BCdyaJL/Ssq6oTdgKcVUBSh2BII2oU+sttV
 ecWbKpu70lESoJDAcsv0lXwvx07tynJ7eNdW3D4REVKuw0BdPjcPkI3qjL7eyNRw1ikd9/Kep
 bnMPAsfRIeDkbNDu5HKUYZziuZQ+rDL3wX4ZQh0M5zvEnDKQQ7ao22hMHeF5HttlHo7j7kBsr
 SBEp/IIYng2xB8hK2juSQCSrriAv4frGKPVlQuWEhsJtrmL4N1pQMyPXVa5vlkRumb5j9Y575
 RurDMzLcXjUk+DNB3VfJZfQY13lyP9TRMdcmdF/8iyYUNhokijDyW6OGl2ZcptYU57mg1mn35
 WXx+gGRZ8OvEmgH8Adw9FYmkq/dAT/6HKGyd7ZfGzQvoAnRV89YHGodH/L0414MH9JmnTpCpI
 goqA+ognB/fN5yuP919sKtuEo0KqX5TJtbnomJickKwpi6bhD/JLgTq6t5rYq305LZwh3V3iK
 OWzAvy9og0GIV4/tAIl1tO59MaKYf4Jn7AEIiGHNMe3Oj3ko4cz2FfKue8lmpYplbnHGOwDPc
 6LPDVHagzO6qa70bQ4Gv9llAiOXToQvLWXcmDySzZJ5/LpYp44q+l0jHR1BMv2zUk+90s7vrk
 4yTl0/SIDguuv5NG39l57oLmZbEuMMLEbqBlmac8YZ8/iaPvkK39hs4dVQSc4HjZcKiMa4Fzc
 MV1yaXRWMb/fR7NZDBbv3mDPGqTwsp5HZW4TzEMWF4uFEnlAtTSL3Xns/LIOAusoitQPTDGUp
 H1zyjdpt6XYPGx3d6diD8rIq+nW4jhpwV+UD4re43PHvScbEs2Omuqo04uuO3eavxgmae26tC
 6LAMUB8EYaSMzPrwEr/RavbNClLho2zcLOfS5QDolc9rna6TUQsVOYVq/V88IYTUsoce2T7ug
 m/f+5kqLNFStp+2aTBQCjG6TUey84zJXzc8FjGVoGBSvxXfqeU7HTShckbQzDRhAeZ92oID8H
 o04wxVl/EgW4Q9b/TZNQ4z9aVVmJ0CCXIFs4R48cmHufzn9EI6krvCJS2QSHx/euHF6sSXWUa
 NNirjIOYkJY82JMmOEVtBD7qpV+2AU18wSLPuvHkxhUkp613AAth7qcOVrwM8dGNvw5lE=
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 16.07.19 20:55, Christian Brauner wrote:
> On Tue, Jul 16, 2019 at 08:53:10PM +0200, Sven Schnelle wrote:
>> Hi,
>>
>> [Adding Helge to CC list]
>>
>> On Tue, Jul 16, 2019 at 03:06:33PM +0200, Christian Brauner wrote:
>>> On Mon, Jul 15, 2019 at 03:56:04PM +0200, Christian Borntraeger wrote:
>>>> I think Vasily already has a clone3 patch for s390x with 435.
>>>
>>> A quick follow-up on this. Helge and Michael have asked whether there
>>> are any tests for clone3. Yes, there will be and I try to have them
>>> ready by the end of the this or next week for review. In the meantime =
I
>>> hope the following minimalistic test program that just verifies very
>>> very basic functionality (It's not pretty.) will help you test:
>>> [..]
>>
>> On PA-RISC this seems to work fine with Helge's patch to wire up the
>> clone3 syscall.
>
> [...]
> In any case, I saw Helge's patch and I think I might've missed to add an
> Acked-by but feel free to add it.

Thanks!
I've added the patch to the parisc-linux for-next tree.

Helge
