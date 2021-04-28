Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E724D36D0D5
	for <lists+linux-arch@lfdr.de>; Wed, 28 Apr 2021 05:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhD1DTC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Apr 2021 23:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhD1DS6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Apr 2021 23:18:58 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD944C061574;
        Tue, 27 Apr 2021 20:18:09 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso55336580otb.13;
        Tue, 27 Apr 2021 20:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YsKXqMxnWaheIKomrBNLMLiA91AUivCW/MY4aVdmRJo=;
        b=TrdlinmZsn+N1assTFm2B8Uzlj+iLdkcpBVMg0qpDpTm8c3dD2Aq+Gjw6VVW1as5F5
         8fPH5TW/hZVIgvRe8LocCO9CDqMCYk+MJEsaCCDwboqOqRUJkdi/z5agvLZFSyEYAS5C
         MVBewibFDf0U668z9zOjI6mJnZaU7bsleRMQPu+rSWuNnLdNFioFGdxyzymOuslVfEVt
         SKnKZjBUIB2/UaIMGgI3F229XnKnDs51YaSbubX19TtAfmNJNxSduwq+6cE/jSLWu6l4
         6s10BP8sXLtL6aEDDSxe6vLagYoocLBLV7pbp/BQHin3g2D1p3FnBzg/+hHElL4izf6a
         XOUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=YsKXqMxnWaheIKomrBNLMLiA91AUivCW/MY4aVdmRJo=;
        b=nN6uQ4kGpLD46mQD959/OmPgLtr91egABKGBvTsBmbXyilun7ssTEQj6egvrEKbWsT
         3/rYb2jfr+QMYICSG1WFe5/YAgtS0NZi9tW2uPQXRqTZWCn7sfnk/mIIc6jHN/fTjgu5
         AnXK18dwq0oBpD68NCMG8VRSH522P1k2/VhYAe6UA5GxYkIqp0/svQqkbNt9ElMM1VEy
         UXQURGwTtzXZWp6DE3XO+jSW+VncZCg1H19zPMT9irWGdY2PE0ScPCkKVvUTC55XbK0I
         4j2sdvZTXeT2l1hgWTbLrXWFbDhe9MsFtwj1z8xnYIUZ3ajSMTV1L8AkgSGcNBQFH0mU
         yzPQ==
X-Gm-Message-State: AOAM530G6OHP9/uvvUtOYt/DZeplCuqmks+eX7Bg+zapCB6mEr56bCHQ
        v6K8ntppO4ZDsqlBnldteCrNz9Ipyq4=
X-Google-Smtp-Source: ABdhPJxrneilmSFjHNXwRbpBuDiI7HmDeOY+tTijSE/MDaA2H9rxFD6xLkPE6cQFy92U82d8wXCHdA==
X-Received: by 2002:a05:6830:1507:: with SMTP id k7mr10191701otp.106.1619579889009;
        Tue, 27 Apr 2021 20:18:09 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 186sm1069891oof.14.2021.04.27.20.18.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Apr 2021 20:18:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 27 Apr 2021 20:18:07 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     guoren@kernel.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-arch@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH] csky: uaccess.h: Coding convention with asm generic
Message-ID: <20210428031807.GA27619@roeck-us.net>
References: <1618995255-91499-1-git-send-email-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618995255-91499-1-git-send-email-guoren@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 21, 2021 at 08:54:15AM +0000, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Using asm-generic/uaccess.h to prevent duplicated code:
>  - Add user_addr_max which mentioned in generic uaccess.h
>  - Remove custom definitions of KERNEL/USER_DS, get/set_fs,
>    uaccess_kerenl
>  - Using generic extable.h instead of custom definitions in
>    uaccess.h
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Arnd Bergmann <arnd@arndb.de>

Building csky:tinyconfig ... failed
--------------
Error log:
csky-linux-ld: fs/readdir.o: in function `__put_user_fn':
readdir.c:(.text+0x7c): undefined reference to `__put_user_bad'
csky-linux-ld: fs/readdir.o: in function `$d':
readdir.c:(.text+0x1bc): undefined reference to `__put_user_bad'
make[1]: *** [Makefile:1277: vmlinux] Error 1
make: *** [Makefile:222: __sub-make] Error 2

Bisect log attached.

Guenter

---
# bad: [3f1fee3e7237347f09a2c7fa538119e6d9ea4b84] Add linux-next specific files for 20210426
# good: [9f4ad9e425a1d3b6a34617b8ea226d56a119a717] Linux 5.12
git bisect start 'HEAD' 'v5.12'
# bad: [bb8f486776983897309645c98705670c3d2a16e5] Merge remote-tracking branch 'crypto/master'
git bisect bad bb8f486776983897309645c98705670c3d2a16e5
# bad: [6ab4f4364c450991a476eef5bc57bef3586354ed] Merge remote-tracking branch 'jc_docs/docs-next'
git bisect bad 6ab4f4364c450991a476eef5bc57bef3586354ed
# bad: [fd73cab0b2a046136842b23f027dae3686588ba5] Merge remote-tracking branch 'parisc-hd/for-next'
git bisect bad fd73cab0b2a046136842b23f027dae3686588ba5
# good: [f0e6103e023e0ede67848ddcd6b07044574f4fd3] soc: document merges
git bisect good f0e6103e023e0ede67848ddcd6b07044574f4fd3
# good: [70361dc0add47d3818acf9c33718ce7395f8aaa5] Merge remote-tracking branch 'arm-soc/for-next'
git bisect good 70361dc0add47d3818acf9c33718ce7395f8aaa5
# good: [f62ad9f6e1100e3a1b6ca7a004fd5a972ff768df] Merge remote-tracking branch 'ti-k3/ti-k3-next'
git bisect good f62ad9f6e1100e3a1b6ca7a004fd5a972ff768df
# bad: [b3b33dda4fd25e201c77f0ce9277dd34f31e86ce] Merge remote-tracking branch 'h8300/h8300-next'
git bisect bad b3b33dda4fd25e201c77f0ce9277dd34f31e86ce
# good: [6a861bd8cf3c96f5825d031732e365b7721a84a5] Merge branch 'clk-qcom' into clk-next
git bisect good 6a861bd8cf3c96f5825d031732e365b7721a84a5
# good: [1dd129f1deec0606fb70992521a7e5bcd2f85c69] Merge branch 'clk-qcom' into clk-next
git bisect good 1dd129f1deec0606fb70992521a7e5bcd2f85c69
# good: [8808515be0ed4e33de9bfdc65f4c1b547ee11065] h8300: Replace <linux/clk-provider.h> by <linux/of_clk.h>
git bisect good 8808515be0ed4e33de9bfdc65f4c1b547ee11065
# good: [e27d3ecdeb8923f35cb856fd20be14256aaa7575] Merge remote-tracking branch 'clk/clk-next'
git bisect good e27d3ecdeb8923f35cb856fd20be14256aaa7575
# bad: [d3900e8d918f8fbd1366b9c2998e2830e66a0081] csky: uaccess.h: Coding convention with asm generic
git bisect bad d3900e8d918f8fbd1366b9c2998e2830e66a0081
# good: [0b1f557a1fa02174a982f557581e348d91987ec6] csky: Fixup typos
git bisect good 0b1f557a1fa02174a982f557581e348d91987ec6
# good: [8bfe70e696584deeed1de1bcbfcde405aa1a1344] csky: fix syscache.c fallthrough warning
git bisect good 8bfe70e696584deeed1de1bcbfcde405aa1a1344
# first bad commit: [d3900e8d918f8fbd1366b9c2998e2830e66a0081] csky: uaccess.h: Coding convention with asm generic
