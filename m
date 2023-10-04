Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F2F7B77A0
	for <lists+linux-arch@lfdr.de>; Wed,  4 Oct 2023 08:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbjJDGKA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Oct 2023 02:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbjJDGKA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Oct 2023 02:10:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901CDAD;
        Tue,  3 Oct 2023 23:09:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA553C433C7;
        Wed,  4 Oct 2023 06:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696399797;
        bh=Xec0FwIwMIIelHtMmVgwwJFxppLB+fwZSkk9L39ie64=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u1NmNpVkwlrXDhaN6oVwQK5RZl764lQNoqwExFJhHbrk5ETShsX0kithgrUaZ7A6Z
         CFuoW9B+anjwzNmTAIF+XaKoeIVE1UKuR1qw85B3yoPf2PXt2Y3Jb8DFKr4afMOdTG
         wBTlDNsy/X3dG8DtqIhl2xmsrpsppNGz5EO8/x3k=
Date:   Wed, 4 Oct 2023 08:09:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc:     Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        patches@lists.linux.dev, mikelley@microsoft.com, kys@microsoft.com,
        haiyangz@microsoft.com, decui@microsoft.com,
        apais@linux.microsoft.com, Tianyu.Lan@microsoft.com,
        ssengar@linux.microsoft.com, mukeshrathor@microsoft.com,
        stanislav.kinsburskiy@gmail.com, jinankjain@linux.microsoft.com,
        vkuznets@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        will@kernel.org, catalin.marinas@arm.com
Subject: Re: [PATCH v4 13/15] uapi: hyperv: Add mshv driver headers defining
 hypervisor ABIs
Message-ID: <2023100443-wrinkly-romp-79d9@gregkh>
References: <1696010501-24584-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1696010501-24584-14-git-send-email-nunodasneves@linux.microsoft.com>
 <2023093057-eggplant-reshoot-8513@gregkh>
 <ZRia1uyFfEkSqmXw@liuwe-devbox-debian-v2>
 <2023100154-ferret-rift-acef@gregkh>
 <dd5159fe-5337-44ed-bf1b-58220221b597@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd5159fe-5337-44ed-bf1b-58220221b597@linux.microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 03, 2023 at 04:37:01PM -0700, Nuno Das Neves wrote:
> On 9/30/2023 11:19 PM, Greg KH wrote:
> > On Sat, Sep 30, 2023 at 10:01:58PM +0000, Wei Liu wrote:
> > > On Sat, Sep 30, 2023 at 08:09:19AM +0200, Greg KH wrote:
> > > > On Fri, Sep 29, 2023 at 11:01:39AM -0700, Nuno Das Neves wrote:
> > > > > +/* Define connection identifier type. */
> > > > > +union hv_connection_id {
> > > > > +	__u32 asu32;
> > > > > +	struct {
> > > > > +		__u32 id:24;
> > > > > +		__u32 reserved:8;
> > > > > +	} __packed u;
> > > > 
> > > > bitfields will not work properly in uapi .h files, please never do that.
> > > 
> > > Can you clarify a bit more why it wouldn't work? Endianess? Alignment?
> > 
> > Yes to both.
> > 
> > Did you all read the documentation for how to write a kernel api?  If
> > not, please do so.  I think it mentions bitfields, but it not, it really
> > should as of course, this will not work properly with different endian
> > systems or many compilers.
> 
> Yes, in https://docs.kernel.org/driver-api/ioctl.html it says that it is
> "better to avoid" bitfields.
> 
> Unfortunately bitfields are used in the definition of the hypervisor
> ABI. We import these definitions directly from the hypervisor code.

So why do you feel you have to use this specific format for your
user/kernel api?  That is not what is going to the hypervisor.

> In practice the hypervisor, linux, and VMM compilers all produce the
> same layout for bitfields on the architectures we support.

You are getting lucky, please do this properly, without a bitfield
marking in the structure.

thanks,

greg k-h
