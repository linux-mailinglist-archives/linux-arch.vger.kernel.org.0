Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDD36B2F72
	for <lists+linux-arch@lfdr.de>; Thu,  9 Mar 2023 22:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjCIVRh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Mar 2023 16:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjCIVR1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Mar 2023 16:17:27 -0500
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3884AFFBE9;
        Thu,  9 Mar 2023 13:17:15 -0800 (PST)
Received: by mail-wr1-f46.google.com with SMTP id g3so3252744wri.6;
        Thu, 09 Mar 2023 13:17:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678396633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8dQHhXSJ1fnfi7P2Y78mV0gCGQ/b1IV17ij7Uj/LYk=;
        b=OO16La+IsUTTiYgf/OJjgbf8n+t+hI0uJ7oLVXQOhVUS1DoTj7Z1ZlDVUyhe2Dby4D
         pYbJQ6ImwLlPPyViCbt8TmRe0fbQ6ubTmAZRuWXsYEiSZclAnLAxplZMLjtOce9J6zqo
         i8rkOmFYHCoWqjdbRLL5IAXqOvmThbOMpJipAWU0+gqt0YLjjYlIWF2MtGy8Q2+FkZQu
         tUwKY39uUOu0B8SHvf8XFMD8jGaPSTzXy1NnfGM657Whxuhq4/W4oSnF+IDlmhFVZRc4
         ItT6LXRd1uzX6u3aWrSEEfOLom2wLUGMs3R4tE41kPuWXGgszqdfoQQVmueUVLhRf9K7
         JKEw==
X-Gm-Message-State: AO0yUKWJUFiFGrmp15K98UGRe/sUJ6o7d9p72q/EzeQAEnFlbZGlFWAu
        CuJuFTHF6s4OoQMzBIIMw7w=
X-Google-Smtp-Source: AK7set/pgbmbEva5WzpAaoO2T5cGk33MFlFSDNu70MSwCn9I/1LUJkZ7xr3SVprX5qq4FyT2iyjS5A==
X-Received: by 2002:adf:f3c7:0:b0:2cc:23fc:88e3 with SMTP id g7-20020adff3c7000000b002cc23fc88e3mr15608864wrp.40.1678396633569;
        Thu, 09 Mar 2023 13:17:13 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id c7-20020adffb47000000b002c567b58e9asm357984wrs.56.2023.03.09.13.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 13:17:13 -0800 (PST)
Date:   Thu, 9 Mar 2023 21:17:07 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, arnd@arndb.de, tiala@microsoft.com,
        mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 1/2] x86/init: Make get/set_rtc_noop() public
Message-ID: <ZApM00Y+03gpDRGv@liuwe-devbox-debian-v2>
References: <1678386957-18016-1-git-send-email-ssengar@linux.microsoft.com>
 <1678386957-18016-2-git-send-email-ssengar@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1678386957-18016-2-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 09, 2023 at 10:35:56AM -0800, Saurabh Sengar wrote:
> Make get/set_rtc_noop() to be public so that they can be used
> in other modules as well.
> 
> Co-developed-by: Tianyu Lan <tiala@microsoft.com>
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>

Reviewed-by: Wei Liu <wei.liu@kernel.org>
