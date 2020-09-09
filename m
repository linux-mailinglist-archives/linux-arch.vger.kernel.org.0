Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1937D26378F
	for <lists+linux-arch@lfdr.de>; Wed,  9 Sep 2020 22:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgIIUjB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Sep 2020 16:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgIIUi7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Sep 2020 16:38:59 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105B6C061573
        for <linux-arch@vger.kernel.org>; Wed,  9 Sep 2020 13:38:59 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d9so3213229pfd.3
        for <linux-arch@vger.kernel.org>; Wed, 09 Sep 2020 13:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=pvTELsnuqawB+9CsCnyO4FXHa5jqvr6EqiJIinGYuyw=;
        b=PLZPiLkU77f9XNFW8QrusL13z1a4SsShUnxQOOKJxFwPNbQngptnHWjyTnlNrh07Z1
         SuqvnFhCNi6xZ/LkCG84M89gi4WieZbxofhpHM7yRfQII/7rVu80rUgab7G/+IlPoz0J
         JoSyqkqgDva2xC4i2QaBP1cVEasVCAG3wQZconV7kVDWiV4jdOGAVWH9vRqle8i/wmO1
         EYlHBTpm25ht0q8HDx8RZZYKF0kBclWfL0cElzSE4wFlHLJcqYpxXsNrhLKVIoOyDk8m
         RlrCE4sT1WGbMYlovipYVFkhBxIAkVxwB1y5mBogm1g+gjJ1RAsV+LUr0FmpAA6OME5m
         D+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=pvTELsnuqawB+9CsCnyO4FXHa5jqvr6EqiJIinGYuyw=;
        b=UoF9rq2NJflYCA1phGJiWdrrL6FGrG6k0th6fpq30A70nlP5jV6521vgcqQZACq5UN
         uXVkz6RaFWR347zb1gpqIv2aHSuujzreQuLVhjgCz5MVSylohFFNte99bzA++xy5U0wa
         Vs058n+jL7QU9mrhU/+ZTZC20Jmf5MQuzKICC8VBrnOS3sVyDz26p01XVMYszhVjv2PZ
         PPDXfti9M2IZUIQMFTnepr93OiegUS2ZjVGn9rgbkSp4JqrgnOnMjkUzvn4UkV++WdkW
         4LQ/4TzTPguFY7ctkKi6e944eYEn5WOEDY+A/V0bUCvlfMTfFLLse74oUrPRSQhJe8bM
         uHmA==
X-Gm-Message-State: AOAM532NcE/TC6jKEOiH12cR73sv4QKIJA42QaaI/EyBSd1Tw1vG9A+Y
        5c7XahcwctcEw7nUZzQIh6E7NWx4I86exA==
X-Google-Smtp-Source: ABdhPJzrC5l7v5FTB1r/YYtUR1nC0/3uzkDrW1qiPAnWCKJr6AMnKAG1nnvmAvNG0lAHQfGXBcYCqQ==
X-Received: by 2002:a62:ce4b:0:b029:13e:d13d:a100 with SMTP id y72-20020a62ce4b0000b029013ed13da100mr2268407pfg.28.1599683938493;
        Wed, 09 Sep 2020 13:38:58 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id z23sm3514558pfg.220.2020.09.09.13.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 13:38:57 -0700 (PDT)
Date:   Wed, 09 Sep 2020 13:38:57 -0700 (PDT)
X-Google-Original-Date: Wed, 09 Sep 2020 13:38:04 PDT (-0700)
Subject:     Re: remove set_fs for riscv v2
In-Reply-To: <20200909065515.GA9618@lst.de>
CC:     viro@zeniv.linux.org.uk, Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@lst.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Christoph Hellwig <hch@lst.de>
Message-ID: <mhng-e33e9c39-7441-44f4-9c77-2243bb81168b@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 08 Sep 2020 23:55:15 PDT (-0700), Christoph Hellwig wrote:
> On Tue, Sep 08, 2020 at 09:59:29PM -0700, Palmer Dabbelt wrote:
>>>
>>> The first four patches are general improvements and enablement for all nommu
>>> ports, and might make sense to merge through the above base branch.
>>
>> Seems like it to me.  These won't work without the SET_FS code so I'm OK if you
>> guys want to keep them all together.  Otherwise I think I'd need to wait until
>> the SET_FS stuff gets merged before taking any of these, which would be a bit
>> of a headache.
>
> now that we've sorted out a remaining issue base.set_fs should not
> be rebased any more, so you could pull it into the riscv tree or a topic
> branch.
>
> The first four patch should go into base.set_fs, though.  Arnd, can you
> re-review the updated patches?

OK, assuming the first four land through vfs I'll take the rest through my
tree.  I wasn't sure it was OK to merge another subtree into my tree, as IIRC I
got told not to do something like that before, but I'll go figure out a sane
way to handle it.

Thanks!
