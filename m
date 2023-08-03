Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1242276F46B
	for <lists+linux-arch@lfdr.de>; Thu,  3 Aug 2023 23:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjHCVFj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Aug 2023 17:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjHCVFi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Aug 2023 17:05:38 -0400
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6BD2D42;
        Thu,  3 Aug 2023 14:05:37 -0700 (PDT)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-686be28e1a8so1023238b3a.0;
        Thu, 03 Aug 2023 14:05:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691096737; x=1691701537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxzSFjfvH9nf9VFKvjEOffow7qbCJzDE9eBHaKMndwA=;
        b=Mc+nFpedC0XNZj1F7QNVx4BVicDYJKJLdaVb7uIDwJxg8g6mkOilnZb1KjOLiSYahC
         2M4ZzexFIt0IawxIOwBhq97K+bEp8wpi1LLdmTP0eDwMDWh7ZM8txptG5wnYduu9wM69
         dA1IZMD9sUpH2qxGdugJ7NLUHdztBx+dF+UmETFeJ340ulmObYvM/f9Hft2BlJq0tOQp
         W81xGojHOnxfr5dJnwcEqkmAwuHm7oAVRLPrPwjVcZjRE6+FxY4cFtXdInu+ABb9y5iy
         R7CHyqX8uXgvCEQ60w56TPNaj0OI6P1eXPF8GsI+9ZmKWx6weGid3i43r/wjAvflFDpP
         apgg==
X-Gm-Message-State: ABy/qLZOjj/fsY/NooYSqCmzalWAZ2HqOx/OaqSBWm94H+i8ikvRYIDF
        CyjSwbT3YuFPoWDSclSKj90=
X-Google-Smtp-Source: APBJJlGu2lOhqqVnRMmnRl3Qe5W4oVpe+V4SQ0lBNbq9foy8XkQHe6fWAD/dppuFdvz7sCyDqTvNFg==
X-Received: by 2002:a05:6a21:3d87:b0:131:b3fa:eaaa with SMTP id bj7-20020a056a213d8700b00131b3faeaaamr18213182pzc.61.1691096737256;
        Thu, 03 Aug 2023 14:05:37 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id j14-20020a633c0e000000b00563826c66eesm247153pga.61.2023.08.03.14.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 14:05:36 -0700 (PDT)
Date:   Thu, 3 Aug 2023 21:05:29 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, mikelley@microsoft.com,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        ssengar@linux.microsoft.com, mukeshrathor@microsoft.com,
        stanislav.kinsburskiy@gmail.com, jinankjain@linux.microsoft.com,
        apais@linux.microsoft.com, Tianyu.Lan@microsoft.com,
        vkuznets@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        will@kernel.org, catalin.marinas@arm.com
Subject: Re: [PATCH 12/15] Documentation: Reserve ioctl number for mshv driver
Message-ID: <ZMwWmZThinOGSP+s@liuwe-devbox-debian-v2>
References: <1690487690-2428-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1690487690-2428-13-git-send-email-nunodasneves@linux.microsoft.com>
 <ZMrzgeETgsn1iTfe@liuwe-devbox-debian-v2>
 <878ras8dkc.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878ras8dkc.fsf@meer.lwn.net>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 03, 2023 at 07:23:31AM -0600, Jonathan Corbet wrote:
> Wei Liu <wei.liu@kernel.org> writes:
> 
> > This needs an ack from Jonathan.
> 
> From me?  If every docs change needed an ack from me we'd be in rather
> worse shape than we are now.  You can certainly have one:
> 
> Acked-by: Jonathan Corbet <corbet@lwn.net>
> 
> ...but I don't control ioctl() numbers and don't need to gate-keep a
> change like this.

Thanks Jonathan.

MAINTAINERS says you're the maintainer for Documentation, and I couldn't
find who owns userspace-api or who controls the allocation of ioctl
numbers.

Thanks,
Wei.

> 
> Thanks,
> 
> jon
> 
> > On Thu, Jul 27, 2023 at 12:54:47PM -0700, Nuno Das Neves wrote:
> >> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> >> ---
> >>  Documentation/userspace-api/ioctl/ioctl-number.rst | 2 ++
> >>  1 file changed, 2 insertions(+)
> >> 
> >> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> >> index 0a1882e296ae..ca6b82419118 100644
> >> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> >> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> >> @@ -355,6 +355,8 @@ Code  Seq#    Include File                                           Comments
> >>  0xB6  all    linux/fpga-dfl.h
> >>  0xB7  all    uapi/linux/remoteproc_cdev.h                            <mailto:linux-remoteproc@vger.kernel.org>
> >>  0xB7  all    uapi/linux/nsfs.h                                       <mailto:Andrei Vagin <avagin@openvz.org>>
> >> +0xB8  all    uapi/linux/mshv.h                                       Microsoft Hypervisor VM management APIs
> >> +                                                                     <mailto:linux-hyperv@vger.kernel.org>
> >>  0xC0  00-0F  linux/usb/iowarrior.h
> >>  0xCA  00-0F  uapi/misc/cxl.h
> >>  0xCA  10-2F  uapi/misc/ocxl.h
> >> -- 
> >> 2.25.1
> >> 
