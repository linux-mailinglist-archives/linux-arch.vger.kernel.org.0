Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B3951595E
	for <lists+linux-arch@lfdr.de>; Sat, 30 Apr 2022 02:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381933AbiD3Alc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Apr 2022 20:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235155AbiD3Alb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Apr 2022 20:41:31 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D5A8CDB5;
        Fri, 29 Apr 2022 17:38:12 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id l16so2911281oil.6;
        Fri, 29 Apr 2022 17:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=q7PgXllbhOxNgMzSzXOXHVCmNKBF6g45A0eVH1K0j2U=;
        b=hqTzrA1Abjeqjk1uuIywMHeKgMXlsnPk64+oJgAYhxTZyG5tcSvnfNptasc6YNAIhX
         4c9Lx3KtgQ2Luaq4dtkkx/7Uy3YESoyLR6Xt563ajlorQC7qpzhGEV2zK76cDz7cahJS
         ByxJQiv9VkOXPILaoZFqsWRl/LWwZpbkiLS4Eyb7DGS0zWDPPlQSvobKLfrsjKHsjLdh
         kfE+P334FpaWBRNC2RwQFNfJXyuO8O3y6maIxzguM0eBSW2zu/72x886qpF4gTpfwZKY
         1rR4/vQUaacaRaO2uZECZUGb/Dh1JwlfU3t2iwTVBKEnZmdREMkf7t6J1EHEGFCOAjGs
         2uag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=q7PgXllbhOxNgMzSzXOXHVCmNKBF6g45A0eVH1K0j2U=;
        b=nxufSqS/KGS/nCZD/kX1Bz7+raUYD2x5IoSsT6vtVatoJP/h+2U1xVyjRN8QoFofCg
         CeLX4O3TWhmxi7oImKwLPIqJJ2OBsBg34H4vW6/9F/VAV5yjOCw4JJpb6a4UsgvhW2mt
         fp3iP6gAFf0a0rm3B7j2qAvX40H8CNmXvoCio4qu39w1RbzWT/uWYkgoQykbBls8HzdY
         uT2hCRw+qz9ltaUC4ZIwcPsiaLtKVai1dXUzpHWquvOrfJWYvi3J8J50c+ekm0XIVWR9
         36htX3KroYROk84t0eNqTHtbq8aoJvVshOFxTI8KuuNWvS3L0fFBcEn+mCrIVQh5MYR+
         Ydvg==
X-Gm-Message-State: AOAM531QaMnPzKvprPyBC8RBE6gor5qKS3Vpz08atDU+tI29Bo49F1HL
        L8mxS9QDYScqi8UrSP2lKTTBa1iQCKezyg==
X-Google-Smtp-Source: ABdhPJz23IcbboOQlzgrMD8ecGs1JP45OtKx9Sbs11gykMKE4owp7iHEqpajqivMwHyMBqKS+UFMmw==
X-Received: by 2002:a05:6808:140f:b0:322:cbe9:8d29 with SMTP id w15-20020a056808140f00b00322cbe98d29mr2816453oiv.220.1651279091520;
        Fri, 29 Apr 2022 17:38:11 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x108-20020a9d37f5000000b006060322123csm298112otb.12.2022.04.29.17.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 17:38:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 29 Apr 2022 17:38:09 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        "open list:WATCHDOG DEVICE DRIVERS" <linux-watchdog@vger.kernel.org>
Subject: Re: [RFC v2 37/39] watchdog: add HAS_IOPORT dependencies
Message-ID: <20220430003809.GB2446353@roeck-us.net>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com>
 <20220429135108.2781579-69-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429135108.2781579-69-schnelle@linux.ibm.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 29, 2022 at 03:51:06PM +0200, Niklas Schnelle wrote:
> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. We thus need to add HAS_IOPORT as dependency for
> those drivers using them.
> 
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

... assuming that the plan is to push those together. If not let me know.

Guenter
