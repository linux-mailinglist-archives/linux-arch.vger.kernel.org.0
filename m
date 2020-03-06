Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD7C317B83F
	for <lists+linux-arch@lfdr.de>; Fri,  6 Mar 2020 09:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbgCFIWE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Mar 2020 03:22:04 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:56543 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgCFIWD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Mar 2020 03:22:03 -0500
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1M4skB-1jAxqr1PZn-001x6Y; Fri, 06 Mar 2020 09:21:50 +0100
Subject: Re: [PATCH] binfmt_misc: pass binfmt_misc P flag to the interpreter
To:     Florian Weimer <fw@deneb.enyo.de>, YunQiang Su <syq@debian.org>
Cc:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        James.Bottomley@hansenpartnership.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        libc-alpha@sourceware.org
References: <20200306080905.173466-1-syq@debian.org>
 <87r1y53npd.fsf@mid.deneb.enyo.de>
From:   Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <8441f497-61eb-5c14-bf1e-c90a464105a7@vivier.eu>
Date:   Fri, 6 Mar 2020 09:21:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87r1y53npd.fsf@mid.deneb.enyo.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Q/VP/C7G5/q2fusWYTx9fdXdy9refipmFn9Qp7qBB0TtsSav0up
 EElsf7yuKVoqDSBRN7KW+J5FR4kYSeGWW2FP1RFVz9JmDcC236bsnZGPVUX6S2xXlOkmZ7Z
 E23I/M6yT1uvTs843tzXRou++EwoYfNtaXg44jM8MLT7A8t20SSORM8D53NjVwXjlMMnA52
 lL8AStqqTYXuU2HfJJ9cg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/oeNg09lLzA=:UCJAS6YSkjQgfxltwqDGwI
 FbQ2ylftZyCr1nztHQ0A0srTfDUfqzvgI5tZA9cpnF8kef0gAcSfms/Tm2T8RgK+SUQ2rjMSP
 zwAC4cL5dJo6CHdamEqkJg4tz2nR1xg2dKzirGkHLWv6tgQmMKIaDwqaDsLRxUoVJsMPEsrT/
 3d3IkV82RDbu42x4KjB6AcukTTxeyZJpe8q4kRyHc0dhjfI2mH5lnV19MwopJYPI1eDC9zBVN
 CWFQ9dT4+S/OoI38WY+ZUiU4n/itepf62fnwedY2tJJ2AETKygWvvymsbUYUbYpeioxUFOBlH
 uEiMg1SVRJQCYQAVFMptQkMofDrv7B6H/aEzVo0wZYaB0Iu7Z5aBEUnqNrvm7IdJbbQwQpvDc
 VL7giPFNgEaCO9nDJyXmMIFnBZvEU57SlNMw03ZX+c0jHxZlLY8QkNNHGJ2m/LzqqfjJkzguw
 XkyHUbdvQ2XKbw77yvEkoVirCZFluQ5e1LoaDe12PA0lwFaXPB863H+OIiOef+tQ8uf6I4I1g
 UVM3dtfAIXkC+cX57x6nClhXKk0JDLI6YSg9Dp0HXPfR3BqApfoUW4/LeFbTcWl9OodPmTdB7
 XEDDakYbBHzlGBdgTcUH++C32uHPIrMIcGqgnGCM/Tj6VfWOgZTMufN+jcXmykIqmwDqYdEPp
 54G7lYb9tPMfXoalgs8Jwhgz44NqI9EWQHOPK5Xj452Cl1uTyO/YAfydr5edtdK1YH7LeX6h5
 fIZ/tM4g14lNtVZ6Xy9iLuHNgTI1v5P6nRYKYHqA5nSUOOXfrV6DGGJk+cH5RZMV0WfCDunoI
 3Mt3GfwdCNVDtqr7k7AwDTrV+1jREqGXrZOOZqKgMpDIXZYbG1+XSFV9N0iAcSM9QhI/Plc
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Le 06/03/2020 à 09:13, Florian Weimer a écrit :
> * YunQiang Su:
> 
>> +	if (bprm->interp_flags & BINPRM_FLAGS_PRESERVE_ARGV0)
>> +		flags |= AT_FLAGS_PRESERVE_ARGV0;
>> +	NEW_AUX_ENT(AT_FLAGS, flags);
> 
> Is it necessary to reuse AT_FLAGS?  I think it's cleaner to define a
> separate AT_ tag dedicated to binfmt_misc.
> 

Not necessary, but it seemed simpler and cleaner to re-use a flag that
is marked as unused and with a name matching the new role. It avoids to
patch other packages (like glibc) to add it as it is already defined.

Thanks,
Laurent
