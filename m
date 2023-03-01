Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9BB6A66D8
	for <lists+linux-arch@lfdr.de>; Wed,  1 Mar 2023 05:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjCAEAP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Feb 2023 23:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjCAEAO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Feb 2023 23:00:14 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1AFE060;
        Tue, 28 Feb 2023 20:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1677643211; i=deller@gmx.de;
        bh=meuqcVimTIOxn+m7ODPWNf8ZSnlWVL0T//mg7FZcKV0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=i/h2Oeh9RHzcgJbkedeRqlNuK14+s1GxkSqfowrTuWIVrPDz5bIyajpd+wKIcUW/a
         TgMggBoSd5j2Hv485NZGHIFYc7AL84R7lnnCk4AVMP1aTFTpkLYhLslAq4W8GSPIwu
         X0oRTfK0N0CW7KU/GgtDPFhY4Izm2Nqj0TlB8QdP7JT0RMxSQz9RT0Bl5BObeKDyrC
         IyGXFCrCw7xT7Zgo9o2B9YqpWmX/3sD3WKruBSWgm2fSP4PsvCzMGNSzeiuzAVmj20
         qIAuZ1AyMcWR/8ZUsSdbqBazjdLLCtlnaE79MbgddvOhUWnAXnTa/XFI2vVQK+1WmU
         ZKK+FMPNDPOFQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([92.116.156.241]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MsHs0-1odSW928a2-00to3w; Wed, 01
 Mar 2023 05:00:11 +0100
Message-ID: <11cfe564-a620-4d0b-210f-c0525c16a236@gmx.de>
Date:   Wed, 1 Mar 2023 05:00:11 +0100
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
 <39436c4d-f5a2-edd5-24ba-19e4812ea364@gmx.de>
 <215b226f-7ffd-70d8-4e7b-85b37f288062@gmx.de>
 <2646c13f-33b8-1047-7cfe-bf7e394344b6@gmx.de> <Y/6G5qCEKh68VOcQ@ZenIV>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <Y/6G5qCEKh68VOcQ@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZaAmX5KNS7WeFFOlCpamknrtGgj7KHP2+2qtf1IUetMVq/ls45I
 hwpMHDOmw2C13DmuC7T769IeXqjywZ82F0HsNfcbB0XeE280ut8ZOvr0I38s3CJ4hJ+z22g
 Qye8i8FlIqg5FeQp9pNxOfCLBjvaR4nx0rTNztXN9by2lDa+l9c4JYypwqb25Pl36v/O4Jb
 u/CaVHnAGGA6IiGqxOPeg==
UI-OutboundReport: notjunk:1;M01:P0:RXxhvFuXcFE=;OlmQ9BObwyXzn/bMi23tGTFfybU
 5HhxWsHQMOmpIDuY7ZShfdZrPbaHZ3I6eaKIL7/my5wVD3LQiKVBp/oQI/GHGcv8VLjewwjpn
 QYTUl6QqiySuZMpzYytpTxr2gkK8H+lh7OaZnpsdZFK85Ke6qJWkSyK4wmN9L4tYjgKq0umCA
 QKmgbLJDRat+6+ZfgvGVeIY5mV6uWhrycVD3gaPM4YOwoZae7nEUPN4PyntE9k2gBmPdLfN3J
 ST/73Hv+E2ed62WBH6W4Knkw6lkeoU3aRS/v7cagOWiI6NX3u7+Ms+7bt76+nmjXsfOka+53g
 FnRu/1RSYsk59f/xA7X/ryCp+8dnUhElGIUjUHIDCi+FnriRQJD2j5/zBfniG+3hZM0ms4Fay
 Nj/jAw6bwTM5EsEL775Mf6AOmnQi/OTVH1/ib9s9Hk4TtE9EOMdDzBoWzBeBCymVUJdLV2wEP
 c9qcJcnk6L5+amL7e89l4eIHc/F/TysT8flKHUwOsjvsSO8AsTxk6jU1PsqsERq+8PbcN9Egn
 pAVPyp4/Ot6t3vlni2SI8aVgyNUEDvCpWuIp0Ql37ts9h9noY60oDPHXfl7z3mfTWw0EDqlYy
 GQ1j0EKCroqP2HTWIGmZWbwuorm0MKijYzZLC99SqnBEuhFRk/IE+SXzPv07a9vrhuH+2116k
 ZaqEEo0P69YaylLoPSY+ewsOnJf9zDMRtc+XKZFoQCjUrq+m5J2eQJs3Z/o272Wk4YIFHtpQF
 Z1rq3w1QOtYdfsnpFaOrFeOjPKTAOj+xLBPP2/l3L/l/i6BhilqFVSfHeK7eHjUL4BmQsUIde
 SpQlFPUYahZZNjgZcWhDw3JzJLrg2YKk2/Yxr/tDWO2iF9SNCr1p5dUoRuJl0ss6RPXHqBep1
 ZRi7InvG+/fqzsozf0v8I1JfCAaNVxT3SqScjRjKx+oq8SsjUeO+toBOR1L7dRpyBwIdNLXSf
 6IeRzvoEIyPMz2YPlufci1EhBDY=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/28/23 23:57, Al Viro wrote:
> On Tue, Feb 28, 2023 at 09:22:31PM +0100, Helge Deller wrote:
>
>> Now I can confirm (with the adjusted reproducer), that your patch
>> allows to kill the process with SIGKILL, while without your patch
>> it's not possibe to kill the process at all.
>> I've tested with a 32- and 64-bit parisc kernel.
>>
>> You may add
>> Tested-by: Helge Deller <deller@gmx.de> # parisc
>> to the patch.
>>
>> If you want me to take the patch (with the warning regarding missing ms=
g variable fixed)
>> through the parisc tree, please let me know.
>
> What message do you prefer there?  It matters only for the case when
> we are hitting an oops there, but...

I have no preference on that message. Maybe "Page fault: fault signal on k=
ernel memory"
is too generic, so I'm fine with any better idea/wording you come up with.

Helge
