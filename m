Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70A13256618
	for <lists+linux-arch@lfdr.de>; Sat, 29 Aug 2020 10:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgH2Iie (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 Aug 2020 04:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgH2Iie (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 29 Aug 2020 04:38:34 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE76C061236;
        Sat, 29 Aug 2020 01:38:33 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id i26so1812349ejb.12;
        Sat, 29 Aug 2020 01:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=2TxWDedm4+HOmZS1xWnSJrDf8sE6DXBZMIXyItPAUTg=;
        b=cePYhkR9svEB2w+CxfzMg1Zn/JiBpBtxInZ6S2F/my6sm8WwLdSGVdfN+0RpuNVMfp
         DLngSiJmFTSyKamC//ao46fITSnnfxjHJmlK/QXm1MTZWikZt5y7UePLszaiyNErM+pN
         MB3I7Bfcj+8P39sMiEV3ExAMQwHz/nHrXKWseXEoEoltWUHM0sQbPIFnbE/Up/8++XmI
         DUuI9U0dOUKNnNa0TY0NzK2/91UKlIbc4UhhLLckC9X4gesNUJDvkwQD97rjKyM5d+y4
         MKDMUd1GLmSeJamKEpl3fsKwWAq0ITj+n1VyYuHu0Iu9UaxtSAxqe5CM5lUwxMCdWXYa
         LuhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=2TxWDedm4+HOmZS1xWnSJrDf8sE6DXBZMIXyItPAUTg=;
        b=NUng3RXRjj3eR/fkqusa/dY0OwT0mbq08l+dNg/G7WB0DaPsLO1OyWMlGrBL9FftPu
         G9PZlj2IvS++azPyNorUssZ1N7myEpuAEwvmWyIp2CtqdFQSIy2jFETSp6tEROPCnxc5
         MdPRrltWWiqH38YUP6xS4U0hnjlnxLlaUT+Yb7Y2M3CsYEJw16+3x5w3cbLb/otI0jEA
         cjGjbgdH4HEzNd5v3fsEVACcjTUisZ+h5hZRMcHb2+42GTYu2ycQSZarX/fTSqaJmEa8
         ZEFlTlzFA6prU9mJcX8leu6Wz0ejBBsf9BWvHnhS/neBH8v+Rn2EQdU8xM6xSpjcoWzO
         HsnQ==
X-Gm-Message-State: AOAM532Q7vazm20R89Wv3FfVQMl1dgE/IFhi8tJJyXYZnwKT4kxMSh5W
        7komtqg4QWASryNsvvXrv3c=
X-Google-Smtp-Source: ABdhPJxU0Y2WIo52DBIR8LqtXNEXNQv7UcVU/Z69NKF8l+KfRTZqBPRx0LuILegms5N71EW8Svk25Q==
X-Received: by 2002:a17:906:8688:: with SMTP id g8mr2572144ejx.25.1598690312074;
        Sat, 29 Aug 2020 01:38:32 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:f90b:b3a9:1300:5b1a])
        by smtp.gmail.com with ESMTPSA id r21sm1608272ejz.51.2020.08.29.01.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 01:38:31 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     paulmck@kernel.org, corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        SeongJae Park <sjpark@amazon.de>
Subject: Re: [PATCH v2 3/3] dics/memory-barriers.txt/kokr: Allow architecture to override the flush barrier
Date:   Sat, 29 Aug 2020 10:38:19 +0200
Message-Id: <20200829083819.4350-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <20200829082607.3146-4-sj38.park@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Ah, why I always see the typo only after posting it...  The title should start
with 'docs/', not 'dics/'.  Sorry, I will send a fixed patch as reply to this.
If you want full v3 patchset, just let me know, please.


Thanks,
SeongJae Park

On Sat, 29 Aug 2020 10:26:07 +0200 SeongJae Park <sj38.park@gmail.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> Translate this commit to Korean:
> 
>     3e79f082ebfc ("libnvdimm/nvdimm/flush: Allow architecture to override the flush barrier")
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> Reviewed-by: Yunjae Lee <lyj7694@gmail.com>
> ---
>  .../translations/ko_KR/memory-barriers.txt          | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/translations/ko_KR/memory-barriers.txt b/Documentation/translations/ko_KR/memory-barriers.txt
> index 291039d77694..64d932f5dc77 100644
> --- a/Documentation/translations/ko_KR/memory-barriers.txt
> +++ b/Documentation/translations/ko_KR/memory-barriers.txt
> @@ -1904,6 +1904,19 @@ Mandatory 배리어들은 SMP 시스템에서도 UP 시스템에서도 SMP 효
>       "커널 I/O 배리어의 효과" 섹션을, consistent memory 에 대한 자세한 내용을
>       위해선 Documentation/core-api/dma-api.rst 문서를 참고하세요.
>  
> + (*) pmem_wmb();
> +
> +     이것은 persistent memory 를 위한 것으로, persistent 저장소에 가해진 변경
> +     사항이 플랫폼 연속성 도메인에 도달했을 것을 보장하기 위한 것입니다.
> +
> +     예를 들어, 임시적이지 않은 pmem 영역으로의 쓰기 후, 우리는 쓰기가 플랫폼
> +     연속성 도메인에 도달했을 것을 보장하기 위해 pmem_wmb() 를 사용합니다.
> +     이는 쓰기가 뒤따르는 instruction 들이 유발하는 어떠한 데이터 액세스나
> +     데이터 전송의 시작 전에 persistent 저장소를 업데이트 했을 것을 보장합니다.
> +     이는 wmb() 에 의해 이뤄지는 순서 규칙을 포함합니다.
> +
> +     Persistent memory 에서의 로드를 위해선 현재의 읽기 메모리 배리어로도 읽기
> +     순서를 보장하는데 충분합니다.
>  
>  =========================
>  암묵적 커널 메모리 배리어
> -- 
> 2.17.1
