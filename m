Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC5E4424363
	for <lists+linux-arch@lfdr.de>; Wed,  6 Oct 2021 18:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbhJFQyo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Oct 2021 12:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhJFQyn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Oct 2021 12:54:43 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D97C061746
        for <linux-arch@vger.kernel.org>; Wed,  6 Oct 2021 09:52:51 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id w11so2020394plz.13
        for <linux-arch@vger.kernel.org>; Wed, 06 Oct 2021 09:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=tE2mxdh37dnyxx/6GEpmhKLL+VCgiyppriZBIEN9Yek=;
        b=ZgSYszkACVNYbPHRv6dT0Y71PsmUfzugPsUa5R+6KzBhBz4OXDPWevSFbzHG7TTBrx
         O8hidqI1gV5G8yuWIAwdZe1qu2PgHRfI/GiPxgzXg6Z4gfjM/WGjc3jAwGCC6kA44aQK
         dkLxOk42bZuJmnjwg84M/m6XZb+JBjBg/27Yd9aN8+PRmGfu0Fh+ahVMfZ4kEefzNU6J
         d/1PWGJRMFij2Mj/Rrz1oOf85Ryu0YoxOtWsbCpCDjOAjre797K799fPHa0WKplUU4VQ
         /r0VoP+HkKKJ705siLyeDGON4T9AB90BkuvBG/A6zp/SyPab3luVPsTV1kIEfQh7ptsm
         WY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=tE2mxdh37dnyxx/6GEpmhKLL+VCgiyppriZBIEN9Yek=;
        b=Cns/ctimgZZVk43tjmvVrPg0Gvluj2s29op/FiEKyFLzMVXNMNCyXCMf/UITsaHbPU
         iXCN9+85jbrH7BxJBc/1fCYAu5SZIS8wf4Zse61mXZCJBhkh7lYMUIpfOp39W9gPsigr
         5sTzQAn+7ye5m9VAHs82Ee8HDwq84bjmYH4Oq81QfLSUa3YYgX4OOobFmvGRCHpMBtBT
         qY3xHwth65Tu9994JNw3j5cpMHqjM99tCNbf9z9WlcHuSq7QvQG87W8Jhksig7ttfW+j
         TsvVw2pK+M1JfE2KdIUgnlWqmjRUlmYTRtl/BCUurmGFNvNQASUr5JvfQeohBqRT/DVZ
         LtsQ==
X-Gm-Message-State: AOAM5329YKmmMeXmtmus9wwlVj6NFhy+HW228URfpfhzsmtRlmv3aHmA
        C76g/aDrf3eeMtQ+HHLI9XKS0Q==
X-Google-Smtp-Source: ABdhPJwTBcQVmbKGkS9vwq4EiC9JTSG8DwDNpJPlsNCPI/DX2wwEwAFi6KDnd7CVB87LQIBKqStMNw==
X-Received: by 2002:a17:902:ea93:b0:13e:c727:3026 with SMTP id x19-20020a170902ea9300b0013ec7273026mr12001089plb.53.1633539170709;
        Wed, 06 Oct 2021 09:52:50 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id r130sm14086047pfc.89.2021.10.06.09.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 09:52:50 -0700 (PDT)
Date:   Wed, 06 Oct 2021 09:52:50 -0700 (PDT)
X-Google-Original-Date: Wed, 06 Oct 2021 09:52:48 PDT (-0700)
Subject:     Re: [PATCH] asm-generic: correct reference to GENERIC_LIB_DEVMEM_IS_ALLOWED
In-Reply-To: <CAK8P3a12-atmqjtjqi-RhFXH2Kwa-hxYcxy3Ftz2YjY5yyPHqg@mail.gmail.com>
CC:     lukas.bulwahn@gmail.com, Arnd Bergmann <arnd@arndb.de>,
        mcgrof@kernel.org, linux-arch@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     Arnd Bergmann <arnd@arndb.de>
Message-ID: <mhng-f5938c9b-7fc1-4b0c-9449-7dd1431f5446@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 06 Oct 2021 08:17:38 PDT (-0700), Arnd Bergmann wrote:
> On Wed, Oct 6, 2021 at 5:00 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>>
>> Commit 527701eda5f1 ("lib: Add a generic version of devmem_is_allowed()")
>> introduces the config symbol GENERIC_LIB_DEVMEM_IS_ALLOWED, but then
>> falsely refers to CONFIG_GENERIC_DEVMEM_IS_ALLOWED (note the missing LIB
>> in the reference) in ./include/asm-generic/io.h.
>>
>> Luckily, ./scripts/checkkconfigsymbols.py warns on non-existing configs:
>>
>> GENERIC_DEVMEM_IS_ALLOWED
>> Referencing files: include/asm-generic/io.h
>>
>> Correct the name of the config to the intended one.
>>
>> Fixes: 527701eda5f1 ("lib: Add a generic version of devmem_is_allowed()")
>> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>

Thanks.  I'm going to assume this is going in through some other tree, 
but IIUC I sent the buggy patch up so LMK if you're expecting it to go 
through mine.
