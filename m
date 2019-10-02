Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 421BFC9128
	for <lists+linux-arch@lfdr.de>; Wed,  2 Oct 2019 20:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbfJBSxx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Oct 2019 14:53:53 -0400
Received: from mout.gmx.net ([212.227.17.20]:33339 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727624AbfJBSxx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Oct 2019 14:53:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570042349;
        bh=gf50tgCxneL5EMyZp44NI1YZQOPxU5aMdpSenTmvcmo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=DeM9KzWeINTccN0apbwbQA0VgoA5iZYZVaOVbR0wi+9JSZPSYhljhs8WcIGgyXwmy
         wwkszvWm8nGEVnGGP9X4EDQbmg75Y3WzfITVdaj862afHrIK7P0CwoFJozLvo3525+
         CQ0oLHYknGUyvoWOuK7johO1UU4Saqw5ArIwjGgQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.134.72]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Md6R1-1hhE8F3b8N-00aFk6; Wed, 02
 Oct 2019 20:52:29 +0200
Subject: Re: [RFC][PATCH] sysctl: Remove the sysctl system call
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <andi@firstfloor.org>,
        Andi Kleen <ak@linux.intel.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Apelete Seketeli <apelete@seketeli.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Chee Nouk Phoon <cnphoon@altera.com>,
        Chris Zankel <chris@zankel.net>,
        Christian Ruppert <christian.ruppert@abilis.com>,
        Greg Ungerer <gerg@uclinux.org>,
        Hongliang Tao <taohl@lemote.com>,
        Huacai Chen <chenhc@lemote.com>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Josh Boyer <jwboyer@gmail.com>, Jun Nie <jun.nie@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ley Foon Tan <lftan@altera.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Olof Johansson <olof@lixom.net>,
        Paul Burton <paul.burton@mips.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Pierrick Hascoet <pierrick.hascoet@abilis.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Roland Stigge <stigge@antcom.de>,
        Vineet Gupta <vgupta@synopsys.com>
References: <8736gcjosv.fsf@x220.int.ebiederm.org>
 <201910011140.EA0181F13@keescook> <87imp8hyc8.fsf@x220.int.ebiederm.org>
From:   Helge Deller <deller@gmx.de>
Message-ID: <1dc9f6c4-d1ff-8add-4d42-1c2d1ae685f6@gmx.de>
Date:   Wed, 2 Oct 2019 20:52:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <87imp8hyc8.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DQAGMh4Ko5P2cI/wLHpPo6oM3QodYNWeRmH706TaNGo2oNxaQq8
 yBfKyzR1b/uToJX8hDwMlwWTaX/onk/j3TXNptxpDALp14iKhHJ4aocZoGm2bC7iBkIdz5q
 bNdH1B4HD3l5vl/ryWt4twHoTJAsf6GitjZtqsTqYjVFGGejjFfWStfvPpF7fGBKKyNYe4+
 QsvCqC6P+fBDzGQtwg1Dg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WomUAVeJBRA=:n9zCVEbUl4dS4bqaFBvX3H
 on+raA1uvEXl1I0A+uZkYyEweFIH0qn1+PjkYLCqphuq29Y6wb4y6hPHeSRhCIutvLYDUo0rA
 hfWl30UdiDBzkgM3UcPcc1NDIuuewKMG7zgjrHNXPpPJsLRDQuS4UZlCcsD3WgtMqQO4BcSDv
 X4u00vVhHTJDWyAozjOp314i4KIoHJ/tgl1sUb/iJZE8g+PAWNtUi3f1A7tT6ZfJNIMDl1Ub8
 JCl/4XdMOfGC5Z8fSUbXUpIM6H0PFFv3nxsQwEii+W9rUl98gxT9NqifkbVZD8wqgBv0lvQYy
 Z9U0ToPf9hFw9Y9PpKF+QZjD8ZLjiNZ4IgMtYsoqP22q1rRtjwdYKzs4osZXZIMNmfXP9ecHr
 KYk6ootsiSM2WNxRH5OsB27z+OIoVFyjJm9gZ3T1Z0CE9kJbLgxagbMnnjtn6JRMSgLJUUkBf
 wN2oxZSuvjx73NVv4pnav1xHu8NJHBbZ6mb87MxgY8JW0bXcxhjRLGsOHSitUrdECJ2ZDj5lX
 Mds+FH8jW+gRFO1y5YIPcuIxcYetgv/mpK49RCElNuZCSpStxXxKqM8nGDZJDPTxKH+5zuOuz
 MIoMxLS+WbfhGGWOysB31SK6uYw0yDyb0HJ8FZZKG5i+wIOR1kOghTXrGxc/phGdo5yax+Ucp
 tQWpK8vI6faH8Sd5ElO8JMaoLAASz3C8zy37HC7jJz70kdo3ABXtTl7cNCByWNZ0fb3BkllQv
 KBcMIsBWjVB7ZWxJgy/i650wrfzTLLolyFWW2bxIWTe8w4bRaDlSbVuMx/xB4rHdH+jkObInk
 CHLMdXu+OqRw7iFCctimriEQ6M24A5h+tqXl7lcdVeBIcdpKi7gSALRbj3T3WF8xFuRom1rj/
 mDXdAfHshk5+/sz8zHZVPqZ6uMy3NPXhuukA/qLKIQFWrqugqk67S5LBhGla0Ic1/i22tTgxq
 Nzp99T4fO/YpziLuUdAq9YiWl3eZ0JSYxQSD+1nzBS4shb8/F+TB7onTCKM22dK/vVt57fsEf
 Vh9MtayaH3jL/JCfRSePke9nEeAyhN+sZm8+ANxe3m5o8UJjyzseZeIGA1ha1WqtbsmEzRVvk
 6MP4h7WwQxU9odDq8H7E9gcBqxl0il1TJ6zS2VPjADYQS0TbrS6xn0Y9RagcX1paYjqVnYRkQ
 T9UbHZWu0qbWJTJuU7IeM0HHWGgX0ETuTC/B7Y+3coLI4a9my7Nj7VHmQSKWtCTD3+tN/goqM
 JIzpeGqkAiMfX06ERkLoEgP7S/E5cGXK/Hq9DYw==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 02.10.19 00:53, Eric W. Biederman wrote:
> Kees Cook <keescook@chromium.org> writes:
>>> As there appear to be no users of the sysctl system call, remove the
>>> code....>...
> I copied everyone who had put this into a defconfig and I will wait a
> little more to see if anyone screams.  I think it is a safe guess that
> several of the affected configurations are dead (or at least
> unmaintained) as I received 17 bounces when copying everyone.

  arch/parisc/configs/c8000_defconfig         |    1 -
  arch/parisc/configs/generic-32bit_defconfig |    1 -

I'm not aware that we require the sysctl syscall somewhere on parisc,
so I think it's safe to remove the code.

Helge
