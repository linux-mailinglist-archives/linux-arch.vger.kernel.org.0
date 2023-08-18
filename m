Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A60F7815C7
	for <lists+linux-arch@lfdr.de>; Sat, 19 Aug 2023 01:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242508AbjHRXXo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Aug 2023 19:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242803AbjHRXXd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Aug 2023 19:23:33 -0400
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EF64202;
        Fri, 18 Aug 2023 16:23:32 -0700 (PDT)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1bdbf10333bso12061845ad.1;
        Fri, 18 Aug 2023 16:23:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692401011; x=1693005811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1h2USv9/D30/s9txAiqRvw8UknERd9pDiuV16mFYCUg=;
        b=gsxEyzDul6ltuu5DSqbfYfmR8nHQl65nkw8OR6W4Koep7rhrdowoMclleZbnfkSykH
         0Ffn6YMcIfk+Q4WjxXi65c7lrR0Q599iIz67qAHeIxGUu7Qm3ZeoxAbWgsUUWwRJform
         Uxpx+N8qVFvMH2qav/ucla0USL3R2Uw3OZSD6IecLSQq7wQghbkw5HJauduJOu+DbzFm
         3UsiXdOTxNYfBE8URnFQrkeppna+OP6d0LeD3cEhPLPxgNX3AFOg1lLB4BfbquWJUVyE
         ix56OoK7Lh/6pOWeTPsJEnRXZLkv40NXy8++H5+j7BHR+RaV1+quRsYtMM72J6RVvZmm
         sDhQ==
X-Gm-Message-State: AOJu0YxBhxeWCoaxYshIVkkdCqtiENhJEP5UgJ6ew7W8KTTbHFShsv7l
        eUDcfYwGxQ1YslSzqdcjiQ8=
X-Google-Smtp-Source: AGHT+IF9qWGcmBVVfF0EL+9TcYfKNHMZhClqyBpQhnA0cOKHPR3KnalzNL144dlz2GUaB7RJXZboAw==
X-Received: by 2002:a17:902:c381:b0:1b8:4baa:52ff with SMTP id g1-20020a170902c38100b001b84baa52ffmr679420plg.47.1692401011347;
        Fri, 18 Aug 2023 16:23:31 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902ee4c00b001bbb1eec92dsm2296658plo.224.2023.08.18.16.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 16:23:30 -0700 (PDT)
Date:   Fri, 18 Aug 2023 23:23:13 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, patches@lists.linux.dev,
        mikelley@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        haiyangz@microsoft.com, decui@microsoft.com,
        apais@linux.microsoft.com, Tianyu.Lan@microsoft.com,
        ssengar@linux.microsoft.com, mukeshrathor@microsoft.com,
        stanislav.kinsburskiy@gmail.com, jinankjain@linux.microsoft.com,
        vkuznets@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        will@kernel.org, catalin.marinas@arm.com
Subject: Re: [PATCH v2 06/15] hyperv-tlfs: Introduce hv_status_to_string and
 hv_status_to_errno
Message-ID: <ZN/9YfdgFuC0EEXO@liuwe-devbox-debian-v2>
References: <1692309711-5573-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1692309711-5573-7-git-send-email-nunodasneves@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1692309711-5573-7-git-send-email-nunodasneves@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 17, 2023 at 03:01:42PM -0700, Nuno Das Neves wrote:
> hv_status_to_errno translates hyperv statuses to linux error codes.
> This is useful for returning something linux-friendly from a hypercall
> helper function.
> 
> hv_status_to_string improves clarity of error messages.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

Acked-by: Wei Liu <wei.liu@kernel.org>
