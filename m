Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255387B4458
	for <lists+linux-arch@lfdr.de>; Sun,  1 Oct 2023 00:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjI3WCE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 30 Sep 2023 18:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjI3WCD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 30 Sep 2023 18:02:03 -0400
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AC7CA;
        Sat, 30 Sep 2023 15:02:01 -0700 (PDT)
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-27763c2c22eso7941726a91.3;
        Sat, 30 Sep 2023 15:02:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696111321; x=1696716121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FeR5T76ZTZxvMCUfz5YBmfd55MUtP2rm54Tv0PEqVko=;
        b=jxsFaykwp58tXh7pGzOntCyv8ZjeCZ42ePDOJTifPNGztPWUvRLa/jxE0SLe2/Ou/U
         tSSgb7Rb2umD/7T5TPwyXdhmimqJo8ZZiH1O54ti3VQxalagXonwNQvF4yCJFMdCoXCM
         3X8AUJM8xdjy8Ylwg/5K/17OznRDRggxrlJxWdxJaq06EJeXu50saexc4MsbjWNI8VDb
         APt0EIsrhiDjhYnoABcZlJP9x78meeZ3/VC22SXGt1QoRzUqBroYkEPQnth6vB7W2AyZ
         iunGl9ZGqQY1v5UYBnK7CRYU0jKGFOfSeKyVtdtVuwry2hk0Q42q1QRF5zZtX3O3AYPz
         DUag==
X-Gm-Message-State: AOJu0Yyf3WJ5LdyjErj75ijtAdaUe9fTRYbvOp5tO6opwS6VuXYhnW3F
        QD9COwxoNU3UxyaTv4Lbr9Y=
X-Google-Smtp-Source: AGHT+IGMvC2zEatQKS7y1gd4yv3/ZntbuZf7hxKHO/sCNP9K7IutMwyZgqQ2h5/QzBmBsl2VNuZdMA==
X-Received: by 2002:a17:90a:ea86:b0:277:1070:74a2 with SMTP id h6-20020a17090aea8600b00277107074a2mr6924409pjz.23.1696111320973;
        Sat, 30 Sep 2023 15:02:00 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id c3-20020a17090abf0300b0026b70d2a8a2sm3582958pjs.29.2023.09.30.15.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 15:02:00 -0700 (PDT)
Date:   Sat, 30 Sep 2023 22:01:58 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
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
Subject: Re: [PATCH v4 13/15] uapi: hyperv: Add mshv driver headers defining
 hypervisor ABIs
Message-ID: <ZRia1uyFfEkSqmXw@liuwe-devbox-debian-v2>
References: <1696010501-24584-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1696010501-24584-14-git-send-email-nunodasneves@linux.microsoft.com>
 <2023093057-eggplant-reshoot-8513@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023093057-eggplant-reshoot-8513@gregkh>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Sep 30, 2023 at 08:09:19AM +0200, Greg KH wrote:
> On Fri, Sep 29, 2023 at 11:01:39AM -0700, Nuno Das Neves wrote:
> > These must be in uapi because they will be used in the mshv ioctl API.
> > 
> > Version numbers for each file:
> > hvhdk.h		25212
> > hvhdk_mini.h	25294
> > hvgdk.h		25125
> > hvgdk_mini.h	25294
> 
> what are version numbers?

These are internal version numbers for the hypervisor headers. We keep
track of them so that we can detect if there are any breakages in the
ABI, and thus either ask them to be fixed or we come up with ways to
maintain compatibility. People outside of Microsoft don't need to worry
about this. If you don't think this information belongs in the commit
message, we can drop it.

> 
> > These are unstable interfaces and as such must be compiled independently
> > from published interfaces found in hyperv-tlfs.h.
> 
> uapi files can NOT be unstable, that's the opposite of an api :(
> 

You made a few suggestions in the past. Nuno responded here:

https://lore.kernel.org/linux-hyperv/1692309711-5573-1-git-send-email-nunodasneves@linux.microsoft.com/T/#m3dd8035e381a1344acd7f570c3f5921b7415bedb

> > Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> > Acked-by: Wei Liu <wei.liu@kernel.org>
> > ---
> >  include/uapi/hyperv/hvgdk.h      |   41 +
> >  include/uapi/hyperv/hvgdk_mini.h | 1076 ++++++++++++++++++++++++
> >  include/uapi/hyperv/hvhdk.h      | 1342 ++++++++++++++++++++++++++++++
> >  include/uapi/hyperv/hvhdk_mini.h |  160 ++++
> >  4 files changed, 2619 insertions(+)
> >  create mode 100644 include/uapi/hyperv/hvgdk.h
> >  create mode 100644 include/uapi/hyperv/hvgdk_mini.h
> >  create mode 100644 include/uapi/hyperv/hvhdk.h
> >  create mode 100644 include/uapi/hyperv/hvhdk_mini.h
> > 
> > diff --git a/include/uapi/hyperv/hvgdk.h b/include/uapi/hyperv/hvgdk.h
> > new file mode 100644
> > index 000000000000..9bcbb7d902b2
> > --- /dev/null
> > +++ b/include/uapi/hyperv/hvgdk.h
> > @@ -0,0 +1,41 @@
> > +/* SPDX-License-Identifier: MIT */
> 
> That's usually not a good license for a new uapi .h file, why did you
> choose this one?
> 

This is chosen so that other Microsoft developers who don't normally
work on Linux can review this code.

> > +/* Define connection identifier type. */
> > +union hv_connection_id {
> > +	__u32 asu32;
> > +	struct {
> > +		__u32 id:24;
> > +		__u32 reserved:8;
> > +	} __packed u;
> 
> bitfields will not work properly in uapi .h files, please never do that.

Can you clarify a bit more why it wouldn't work? Endianess? Alignment?
Or something else?

Just by eyeballing the header files under include/uapi, there are a
non-trivial number of files that use bitfields.

include/uapi/linux/cdrom.h
include/uapi/linux/hdreg.h
include/uapi/linux/if_pppox.h
include/uapi/linux/adfs_fs.h
include/uapi/linux/atm.h
include/uapi/linux/batadv_packet.h
include/uapi/linux/bpf.h
include/uapi/linux/cciss_defs.h
include/uapi/linux/dccp.h
include/uapi/linux/erspan.h
include/uapi/linux/i2o-dev.h
include/uapi/linux/icmp.h
include/uapi/linux/icmpv6.h
include/uapi/linux/idxd.h
include/uapi/linux/if_hippi.h
include/uapi/linux/igmp.h
include/uapi/linux/inet_diag.h
include/uapi/linux/ioam6.h
include/uapi/linux/ip.h
include/uapi/linux/netfilter/xt_policy.h
include/uapi/linux/perf_event.h
include/uapi/linux/rpl.h
include/uapi/linux/tcp.h
include/uapi/linux/usb/raw_gadget.h
include/uapi/linux/watch_queue.h
include/uapi/scsi/scsi_bsg_ufs.h
include/uapi/sound/asound.h
include/uapi/sound/skl-tplg-interface.h

Also under arch/x86/include/uapi/asm:

arch/x86/include/uapi/asm/kvm.h

Can you help us understand how we can make our code work like the others
listed above? There must be a way since they are all in the tree. We're
happy to make adjustments.

Thanks,
Wei.

> 
> thanks,
> 
> greg k-h
