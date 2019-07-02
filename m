Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8A125D08A
	for <lists+linux-arch@lfdr.de>; Tue,  2 Jul 2019 15:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfGBNYa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 2 Jul 2019 09:24:30 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44245 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbfGBNYa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Jul 2019 09:24:30 -0400
Received: by mail-pf1-f194.google.com with SMTP id t16so8237126pfe.11;
        Tue, 02 Jul 2019 06:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zIzMshIE1gAPy52cCdTxKa4XjsXUQnv0LX7WGYv0Rtc=;
        b=SHDt+sNMGv5FFZLWhLgqNvYkSG/Bi9VSnP+fABBnYeVuY2MUaXGJhEeOfMwv6Wt/8S
         FYTvzbzNxuCzi7IH2veGNYiXIJHzcdK8WlrBiqexUIUjAOrQsx6f/lj0bS56UjkmjlDZ
         aIH1rsqyS2EsGRWqyNU5TO3lpHfqc8PPyKpWYEq5BiuIW/qdcA6YSHvWDwffFFu1vQQw
         ntiIylzvlMGla6Hpq0hKUfPp6FME0Y7UURKXHH3cUWwc6UJHmo8XVgsYagC2EkFgufNY
         cY4U3vHkXjv1rR95P/iyjbdpzexdmzmgKTy0r+28ofAdrk7Ir4A4Tcr2gf4BA4xaC4Yw
         oQ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zIzMshIE1gAPy52cCdTxKa4XjsXUQnv0LX7WGYv0Rtc=;
        b=RwdbWCIr8iei84RPus7urQPZbBqoClKveMEfMd4ZDMXOfyM40EQ7yjilPVFSmwI9GW
         O+CkLPmZ6cIZV6XykkUIBzzqAlrHal9RnlQc6pCkFOKBYGpIRoz/P/MpWqdlxF3x++Vf
         LhvUHZiPAWS5/DwJpwV2E2pVt3YQaCbVKfUuf7v+sGxWIhYN7OfcifNeeNE1Y1x++jhm
         htMS2yoil3G4kSqDzyRj3b4VA+adURVbVWpujtKwFn59WfHjFVv3ZhqeZnjc4II1q2nY
         InuneqSZ+XH49QPiqq6vENvd3FdaicrfBGvIUKG2sWQ0m4b/aZ5GoPDf7A4SvVu2RszB
         7gnw==
X-Gm-Message-State: APjAAAVDXoI8LLEmVX4sKBBwgG2ArCghfI+atxcMCf0wUUC0Br24giaQ
        +Vrl+W7g686OoOjgtSWHabf+Fv8A
X-Google-Smtp-Source: APXvYqxwSTNSkpYfR/YcP5lqFi14QfBrf45GvlU8nQ9eECN24EeBhpsFgURltkFD73foirQTcIQUBQ==
X-Received: by 2002:a17:90b:f12:: with SMTP id br18mr5368966pjb.127.1562073869198;
        Tue, 02 Jul 2019 06:24:29 -0700 (PDT)
Received: from [10.44.0.192] ([103.48.210.53])
        by smtp.gmail.com with ESMTPSA id v185sm22709105pfb.14.2019.07.02.06.24.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 06:24:28 -0700 (PDT)
From:   Greg Ungerer <gregungerer00@gmail.com>
X-Google-Original-From: Greg Ungerer <gerg@linux-m68k.org>
Subject: Re: Archs using generic PCI controller drivers vs. resource policy
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arch@vger.kernel.org
References: <5f3dcc3a8dafad188e3adb8ee9cf347bebdee7f6.camel@kernel.crashing.org>
Message-ID: <bafcb3eb-2bf0-2ea7-00e4-50e729406978@linux-m68k.org>
Date:   Tue, 2 Jul 2019 23:24:24 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <5f3dcc3a8dafad188e3adb8ee9cf347bebdee7f6.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Ben,

On 23/6/19 10:30 am, Benjamin Herrenschmidt wrote:
> As part of my cleanup and consolidation of the PCI resource assignment
> policies, I need to clarify something.
> 
> At the moment, unless PCI_PROBE_ONLY is set, a number of
> platforms/archs expect Linux to reassign everything rather than honor
> what has setup, then (re)assign what's left or broken. This is mostly
> the case of embedded platforms. Things like x86 and desktop/server
> powerpc will generally honor the firmware setup.
> 
> One problem is that this policy decision tend to be sprinkled in some
> of the controller drivers themselves in drivers/pci/controller (or the
> pci_host_probe helper).
> 
> This is wrong. I want to move it to the architecture (initially,
> eventually it should be platform driven, but the default will start
> with architecture specific to avoid changing the existing behaviours
> while consolidating the code).
> 
> To do that right, I want to understand which archs can potentially use
> the code in drivers/pci/controller today so I can change those archs to
> explicitely set the default to "reassign everything" (and take the
> policy out of the drivers themselves).
> 
> So far I've counted arm, arm64 (DT, not ACPI) and nios2. Any other ?

For the m68k platforms which support PCI (which is only some of
the more modern ColdFire variants) they expect PCI resources to
be assigned by Linux. There is no boot firmware that will do that
before kernel startup.

The PCI root driver complex is already in the arch area though
(arch/m68k/coldfire/pci.c) so that is essentially what you
want to achieve right?

Regards
Greg


> The remaining archs fall into two categories:
> 
>   - Those who have their own existing PCI management code and don't
> use the generic controller drivers. I'm handling these already.
> 
>   - Those who don't seem to have anything to do with PCI (yet ?) or that
> I've missed. Those will default to the x86 model (honor FW setup unless
> it has conflicts or is broken, and (re)assign what's left) unless
> explicitly changed.
> 
> Cheers,
> Ben.
> 
> 
> 
