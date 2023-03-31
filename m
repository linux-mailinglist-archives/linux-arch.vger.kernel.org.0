Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1886D2109
	for <lists+linux-arch@lfdr.de>; Fri, 31 Mar 2023 15:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbjCaNCe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 Mar 2023 09:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbjCaNCe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 Mar 2023 09:02:34 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848741BCE;
        Fri, 31 Mar 2023 06:02:32 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 02D7431A;
        Fri, 31 Mar 2023 13:02:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 02D7431A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1680267752; bh=lHPjSDZteLZA06uiq0aIjI330xz6NFY+UFe790PqJP0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Jdwqt4L1nuZbnDnZ0Lc9EGCPZ0GbGpqUentJFyOW1mNdaEBU1WR5o6t1BGF0LBvmA
         jlPVCRSTxHTXONxY8PLpDOgF5MuXkGxbRhzG7QUiseBxYXtWm90B1Qz5WFHH8G9KxY
         PQEchHulyCNevg67FM64okHXeLzzbabPVYZBwYOU2TUvvY7LjFOZRKrVZu6/+CTMmr
         jLXAetQgzp6+eV6MiLBTQC9PYRbgK8RUbUeV30PtLBsX77rt0OzWLdyT20OD0jTsDR
         16Y3EzCIXWot4qMLMWeoXBNtcXU295nmRG0T5xtUi2Dd2B8Fd+MoOHM2jl7OsUGDW2
         aRo0vqKDxcUOA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 4/4] docs: move m68k architecture documentation under
 Documentation/arch/
In-Reply-To: <CAMuHMdU=yyEciJD6iU-g90T3Qxg+t27Vz6VuojkhbxdODDJGwA@mail.gmail.com>
References: <20230330195604.269346-1-corbet@lwn.net>
 <20230330195604.269346-5-corbet@lwn.net>
 <CAMuHMdU=yyEciJD6iU-g90T3Qxg+t27Vz6VuojkhbxdODDJGwA@mail.gmail.com>
Date:   Fri, 31 Mar 2023 07:02:31 -0600
Message-ID: <87cz4pdqfs.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

>> diff --git a/Documentation/translations/zh_CN/arch/parisc/debugging.rst b/Documentation/translations/zh_CN/arch/parisc/debugging.rst
>> index 9bd197eb0d41..c6b9de6d3175 100644
>> --- a/Documentation/translations/zh_CN/arch/parisc/debugging.rst
>> +++ b/Documentation/translations/zh_CN/arch/parisc/debugging.rst
>> @@ -1,4 +1,4 @@
>> -.. include:: ../disclaimer-zh_CN.rst
>> +.. include:: ../../disclaimer-zh_CN.rst
>>
>>  :Original: Documentation/arch/parisc/debugging.rst
>>
>> diff --git a/Documentation/translations/zh_CN/arch/parisc/index.rst b/Documentation/translations/zh_CN/arch/parisc/index.rst
>> index 848742539550..9f69283bd1c9 100644
>> --- a/Documentation/translations/zh_CN/arch/parisc/index.rst
>> +++ b/Documentation/translations/zh_CN/arch/parisc/index.rst
>> @@ -1,5 +1,5 @@
>>  .. SPDX-License-Identifier: GPL-2.0
>> -.. include:: ../disclaimer-zh_CN.rst
>> +.. include:: ../../disclaimer-zh_CN.rst
>>
>>  :Original: Documentation/arch/parisc/index.rst
>>
>> diff --git a/Documentation/translations/zh_CN/arch/parisc/registers.rst b/Documentation/translations/zh_CN/arch/parisc/registers.rst
>> index caf5f258248b..a55250afcc27 100644
>> --- a/Documentation/translations/zh_CN/arch/parisc/registers.rst
>> +++ b/Documentation/translations/zh_CN/arch/parisc/registers.rst
>> @@ -1,4 +1,4 @@
>> -.. include:: ../disclaimer-zh_CN.rst
>> +.. include:: ../../disclaimer-zh_CN.rst
>>
>>  :Original: Documentation/arch/parisc/registers.rst
>>
>
> These changes do not belong in this patch.

Why not?  If I don't make those changes when moving the files, the
documentation build will break.

Thanks,

jon
