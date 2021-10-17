Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E56E3430BBD
	for <lists+linux-arch@lfdr.de>; Sun, 17 Oct 2021 21:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242629AbhJQTaF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 17 Oct 2021 15:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233508AbhJQTaF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 17 Oct 2021 15:30:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77849C06161C;
        Sun, 17 Oct 2021 12:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=I673tmyoNJuowK+ZSXqaYY+vNHpRaNf5lXVpV9LQ02Q=; b=rwn8Y1apOW6BXYAFqfvq729mb6
        2e8CP2q1fASg6yDRi4UiV9/JP3T3U/ZKsG+wxxOJf8KwNcHLkVPV8uB9w2YJtwXPa+YDoKgJyvqTZ
        vifRE2TYizw5QWY4m/+O3jDHD8ZPLqjwK/wmguyGqgsHKEFR2w1kda9OM+l0AJDq/yqZBpTMVMI0I
        JGovzz92ZHGlTALnU4zvvkWLPkAewTLHaCokDBXVO/TEy5fU7JCw21kcO/TwNdHu3NmuxTWurOJk3
        K4BI4uhzt/kt9wgG4x6wZTnvzwKyuCiKBuztdOxJfN+ayYF3shxiZp/nhkOsxaBXEW+xliQFlG+nd
        rQOrPbug==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcBp4-00DD3j-CL; Sun, 17 Oct 2021 19:27:54 +0000
Subject: Re: [PATCH] asm-generic: bug.h: add unreachable() in BUG() for
 CONFIG_BUG not set
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
References: <20211017174905.18943-1-rdunlap@infradead.org>
 <CAK8P3a3XDY5gMUA3h3tVmQuxSHn_J3qOw_rDurzBx-KFdGhCKA@mail.gmail.com>
 <8aad5fd2-6850-800a-3c56-199bb5d4f4ae@infradead.org>
 <CAK8P3a21-mu=eN7qu+1C11Rwp_S3T0iJ+ronmMGyeYcw=Ym61A@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <fec67616-f1d0-08da-f393-489233210cbd@infradead.org>
Date:   Sun, 17 Oct 2021 12:27:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a21-mu=eN7qu+1C11Rwp_S3T0iJ+ronmMGyeYcw=Ym61A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/17/21 12:24 PM, Arnd Bergmann wrote:
> On Sun, Oct 17, 2021 at 9:17 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>> On 10/17/21 12:09 PM, Arnd Bergmann wrote:
>>> On Sun, Oct 17, 2021 at 7:49 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>>> Did you see any other issues like this one on m68k, or the
>>> same one on another architecture?
>>
>> No and no.
> 
> Ok, maybe before we waste too much time on it, just add an extra
> return statement to afs_dir_set_page_dirty()?

I think that patch has already been rejected a few times...

-- 
~Randy
